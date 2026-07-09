import '../core/constants/game_constants.dart';
import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/cycle_step.dart';
import '../models/simulation/tile_action.dart';
import '../models/tile_model.dart';
import '../models/tile_type.dart';
import 'rules/collision_resolver.dart';
import 'rules/modifier_processor.dart';
import 'rules/portal_processor.dart';
import 'rules/switch_door_processor.dart';
import 'stability_checker.dart';
import 'utils/board_utils.dart';

/// Runs one gravity cycle and returns the updated board plus actions.
class CycleSimulator {
  CycleSimulator({
    StabilityChecker? stabilityChecker,
    CollisionResolver? collisionResolver,
    ModifierProcessor? modifierProcessor,
    PortalProcessor? portalProcessor,
    SwitchDoorProcessor? switchDoorProcessor,
  })  : _stabilityChecker = stabilityChecker ?? const StabilityChecker(),
        _collisionResolver = collisionResolver ?? const CollisionResolver(),
        _modifierProcessor = modifierProcessor ?? const ModifierProcessor(),
        _portalProcessor = portalProcessor ?? const PortalProcessor(),
        _switchDoorProcessor = switchDoorProcessor ?? const SwitchDoorProcessor();

  final StabilityChecker _stabilityChecker;
  final CollisionResolver _collisionResolver;
  final ModifierProcessor _modifierProcessor;
  final PortalProcessor _portalProcessor;
  final SwitchDoorProcessor _switchDoorProcessor;

  CycleStepResult runCycle(BoardModel board, int cycleIndex) {
    final actions = <TileAction>[];
    var working = board;

    final intentions = <String, Direction>{};
    for (final tile in BoardUtils.sortedMovableTiles(working)) {
      final direction = _stabilityChecker.intendedDirection(working, tile);
      if (direction != null) {
        intentions[tile.id] = direction;
      }
    }

    if (intentions.isEmpty) {
      return CycleStepResult(
        board: working,
        actions: actions,
        cycleIndex: cycleIndex,
        hadMovement: false,
      );
    }

    final processed = <String>{};
    for (final tile in BoardUtils.sortedMovableTiles(working)) {
      if (processed.contains(tile.id)) {
        continue;
      }
      final direction = intentions[tile.id];
      if (direction == null) {
        continue;
      }

      final current = working.tileById(tile.id);
      if (current == null) {
        continue;
      }

      final (targetRow, targetCol) =
          BoardUtils.stepFrom(current.row, current.col, direction);

      if (BoardUtils.blocksCell(working, targetRow, targetCol)) {
        continue;
      }

      final occupant = working.tileAt(targetRow, targetCol);
      final collision = _collisionResolver.resolve(
        moving: current,
        occupant: occupant?.isMovable == true ? occupant : null,
      );

      if (collision.isBlocked || collision.isStopped) {
        continue;
      }

      working = _applyCollision(working, current, collision, targetRow, targetCol);
      actions.addAll(
        collision.toActions(
          moving: current,
          toRow: targetRow,
          toCol: targetCol,
        ),
      );

      if (collision.isAnnihilated) {
        processed.add(current.id);
        if (collision.removedSecondId != null) {
          processed.add(collision.removedSecondId!);
        }
        continue;
      }

      final movedId = collision.survivor?.id ?? current.id;
      processed.add(movedId);
      var movedTile = working.tileById(movedId);
      if (movedTile == null) {
        continue;
      }

      final postMove = _postMoveEffects(
        board: working,
        tile: movedTile,
        row: movedTile.row,
        col: movedTile.col,
        actions: actions,
      );
      working = postMove.board;
    }

    return CycleStepResult(
      board: working,
      actions: actions,
      cycleIndex: cycleIndex,
      hadMovement: actions.isNotEmpty,
    );
  }

  BoardModel _applyCollision(
    BoardModel board,
    TileModel moving,
    CollisionResult collision,
    int targetRow,
    int targetCol,
  ) {
    if (collision.isAnnihilated) {
      return board
          .withoutTile(collision.removedId!)
          .withoutTile(collision.removedSecondId!);
    }

    if (collision.isBlocked || collision.isStopped) {
      return board;
    }

    final survivor = collision.survivor ?? moving;
    var updated = board.withoutTile(moving.id);
    if (collision.removedId != null && collision.removedId != moving.id) {
      updated = updated.withoutTile(collision.removedId!);
    }

    final placed = survivor.movedTo(row: targetRow, col: targetCol);
    return updated.withTile(placed);
  }

  PostMoveEffectsResult _postMoveEffects({
    required BoardModel board,
    required TileModel tile,
    required int row,
    required int col,
    required List<TileAction> actions,
  }) {
    var working = board;
    var current = tile;

    final switchResult = _switchDoorProcessor.processEntry(
      board: working,
      tile: current,
      row: row,
      col: col,
    );
    working = switchResult.board;
    if (switchResult.action != null) {
      actions.add(switchResult.action!);
    }

      final portalResult = _portalProcessor.process(
      board: working,
      tile: current,
      row: row,
      col: col,
    );
    if (portalResult.action != null) {
      actions.add(portalResult.action!);
      current = portalResult.tile;
      working = working.withTile(current);
    }

      // Modifiers must apply at the tile's post-portal location.
      final modifierRow = current.row;
      final modifierCol = current.col;
      final modifierCell = working.backgroundTileAt(modifierRow, modifierCol);
      if (modifierCell != null && _isModifier(modifierCell.type)) {
        final modifierResult = _modifierProcessor.apply(
          board: working,
          tile: current,
          row: modifierRow,
          col: modifierCol,
        );
        current = modifierResult.tile;
        working = working.withoutTile(modifierCell.id).withTile(current);
        if (modifierResult.action != null) {
          actions.add(modifierResult.action!);
        }
      }

      if (current.allowsSplit && current.value.abs() >= 2) {
        final splitResult = _trySplit(working, current, actions);
        if (splitResult != null) {
          working = splitResult;
        }
      }

      return PostMoveEffectsResult(board: working);
  }

  bool _isModifier(TileType type) {
    return type == TileType.multiplier ||
        type == TileType.divider ||
        type == TileType.inverter;
  }

  BoardModel? _trySplit(
    BoardModel board,
    TileModel tile,
    List<TileAction> actions,
  ) {
    final half = tile.value ~/ 2;
    if (half == 0) {
      return null;
    }

    final neighbors = <(int, int)>[];
    for (final direction in Direction.values) {
      final (r, c) = BoardUtils.stepFrom(tile.row, tile.col, direction);
      if (board.isInBounds(r, c) && board.isCellEmpty(r, c)) {
        neighbors.add((r, c));
      }
    }

    if (neighbors.isEmpty) {
      return null;
    }

    final (r, c) = neighbors.first;
    final splitTile = TileModel(
      id: '${tile.id}_split',
      type: TileType.number,
      value: half,
      row: r,
      col: c,
    );
    final remainder = tile.copyWith(value: tile.value - half);

    actions.add(
      TileAction(
        tileId: tile.id,
        actionType: TileActionType.split,
        fromRow: tile.row,
        fromCol: tile.col,
        toRow: r,
        toCol: c,
        resultingValue: half,
        relatedTileId: splitTile.id,
      ),
    );

    return board.withTile(remainder).withTile(splitTile);
  }
}

class CycleStepResult {
  const CycleStepResult({
    required this.board,
    required this.actions,
    required this.cycleIndex,
    required this.hadMovement,
  });

  final BoardModel board;
  final List<TileAction> actions;
  final int cycleIndex;
  final bool hadMovement;
}

class PostMoveEffectsResult {
  const PostMoveEffectsResult({required this.board});

  final BoardModel board;
}

/// Runs gravity cycles until stable or cap reached.
class GravityCycleRunner {
  GravityCycleRunner({CycleSimulator? cycleSimulator})
      : _cycleSimulator = cycleSimulator ?? CycleSimulator();

  final CycleSimulator _cycleSimulator;

  GravityRunResult run(BoardModel initialBoard) {
    final steps = <CycleStep>[];
    var board = initialBoard;
    var hitCycleCap = false;

    for (var cycle = 0; cycle < maxGravityCycles; cycle++) {
      final result = _cycleSimulator.runCycle(board, cycle);
      board = result.board;

      steps.add(
        CycleStep(
          cycleIndex: cycle,
          actions: result.actions,
          boardSnapshot: board,
        ),
      );

      if (!result.hadMovement) {
        return GravityRunResult(
          steps: steps,
          finalBoard: board,
          isStable: true,
          hitCycleCap: false,
        );
      }
    }

    hitCycleCap = true;
    return GravityRunResult(
      steps: steps,
      finalBoard: board,
      isStable: false,
      hitCycleCap: hitCycleCap,
    );
  }
}

class GravityRunResult {
  const GravityRunResult({
    required this.steps,
    required this.finalBoard,
    required this.isStable,
    required this.hitCycleCap,
  });

  final List<CycleStep> steps;
  final BoardModel finalBoard;
  final bool isStable;
  final bool hitCycleCap;
}
