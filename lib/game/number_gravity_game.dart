import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../core/constants/game_constants.dart';
import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/replay/move_record.dart';
import '../../models/simulation/simulation_result.dart';
import '../../models/tile_model.dart';
import '../../simulation/objective_checker.dart';
import '../../simulation/stuck_detector.dart';
import 'bridges/simulation_bridge.dart';
import 'components/board_component.dart';
import 'components/force_line_component.dart';
import 'components/game_selection_overlay.dart';
import 'components/ghost_overlay_component.dart';

typedef MoveCommitCallback =
    void Function(SimulationResult result, BoardModel board);

typedef LevelWonCallback =
    void Function(
      BoardModel board,
      int movesUsed,
      List<MoveRecord> moveRecords,
    );

typedef LevelStuckCallback = void Function(BoardModel board, int movesUsed);

typedef SessionSyncCallback = void Function({
  required int movesUsed,
  required bool canUndo,
  required bool canRedo,
  required bool isAnimating,
  required bool isWon,
  required bool isStuck,
});

typedef TileSelectedCallback = void Function({
  required String tileId,
  required List<Direction> legalDirections,
});

typedef PreviewCallback = void Function({
  required Direction direction,
  required BoardModel ghostBoard,
});

class NumberGravityGame extends FlameGame {
  NumberGravityGame({
    required this.bridge,
    required this.level,
    this.colorBlindMode = false,
    this.reduceMotion = false,
    this.onMoveCommitted,
    this.onLevelWon,
    this.onLevelStuck,
    this.onSessionSync,
    this.onTileSelected,
    this.onPreview,
    this.onSelectionCleared,
  }) : _board = level.board;

  final SimulationBridge bridge;
  final LevelModel level;
  final bool colorBlindMode;
  final bool reduceMotion;
  final MoveCommitCallback? onMoveCommitted;
  final LevelWonCallback? onLevelWon;
  final LevelStuckCallback? onLevelStuck;
  final SessionSyncCallback? onSessionSync;
  final TileSelectedCallback? onTileSelected;
  final PreviewCallback? onPreview;
  final VoidCallback? onSelectionCleared;

  BoardModel _board;
  final List<BoardModel> _boardHistory = [];
  final List<BoardModel> _boardForwardHistory = [];
  final List<MoveRecord> _moveRecords = [];
  int _movesUsed = 0;
  String? _selectedTileId;
  late BoardComponent _boardComponent;
  late GameSelectionOverlay _selectionOverlay;
  late ForceLineComponent _forceLines;
  late GhostOverlayComponent _ghostOverlay;
  bool _animating = false;
  bool _won = false;
  bool _stuck = false;
  bool _paused = false;

  BoardModel get board => _board;
  bool get canUndo => _boardHistory.length > 1;
  bool get canRedo => _boardForwardHistory.isNotEmpty;
  int get movesUsed => _movesUsed;
  bool get isAnimating => _animating;
  bool get isWon => _won;
  bool get isStuck => _stuck;
  List<MoveRecord> get moveRecords => List.unmodifiable(_moveRecords);

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _boardHistory.add(_board);

    _boardComponent = BoardComponent(
      board: _board,
      colorBlindMode: colorBlindMode,
      onTileTapped: _onTileTapped,
    );
    _selectionOverlay = GameSelectionOverlay(
      boardComponent: _boardComponent,
      onDirectionTapped: _onDirectionTapped,
    );
    _selectionOverlay.size = Vector2(
      _boardComponent.boardWidth,
      _boardComponent.boardHeight,
    );
    _forceLines = ForceLineComponent(boardComponent: _boardComponent);
    _ghostOverlay = GhostOverlayComponent(boardComponent: _boardComponent);

    const boardPadding = 16.0;
    final boardRoot = PositionComponent(position: Vector2.all(boardPadding))
      ..add(_boardComponent)
      ..add(_ghostOverlay)
      ..add(_forceLines)
      ..add(_selectionOverlay);

    await world.add(boardRoot);

    final resolution = Vector2(
      _boardComponent.boardWidth + boardPadding * 2,
      _boardComponent.boardHeight + boardPadding * 2,
    );
    camera.viewport = FixedResolutionViewport(resolution: resolution);
    camera.viewfinder
      ..anchor = Anchor.topLeft
      ..position = Vector2.zero();

    _syncSession();
  }

  void _syncSession() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSessionSync?.call(
        movesUsed: _movesUsed,
        canUndo: canUndo,
        canRedo: canRedo,
        isAnimating: _animating,
        isWon: _won,
        isStuck: _stuck,
      );
    });
  }

  void setPaused(bool paused) {
    _paused = paused;
    if (paused) {
      _clearSelection();
    }
  }

  void _clearSelection() {
    _selectionOverlay.clear();
    _forceLines.updateVectors(const []);
    _ghostOverlay.clear();
    _selectedTileId = null;
    onSelectionCleared?.call();
  }

  void _onTileTapped(TileModel tile) {
    if (_animating || _won || _stuck || _paused || !tile.isMovable) {
      return;
    }
    _selectedTileId = tile.id;
    final directions = bridge
        .legalMoves(_board, tile.id)
        .map((move) => move.direction)
        .toList();
    _selectionOverlay.showForTile(tile.id, directions);
    _forceLines.updateVectors(bridge.computeForces(_board, tile.id));
    onTileSelected?.call(tileId: tile.id, legalDirections: directions);
    _syncSession();
  }

  void previewDirection(Direction direction) {
    if (_animating || _won || _stuck || _paused) {
      return;
    }
    _selectedTileId ??= _primaryMovableTileId();
    if (_selectedTileId == null) {
      return;
    }
    final move = Move(tileId: _selectedTileId!, direction: direction);
    final legal = bridge.legalMoves(_board, _selectedTileId!);
    if (!legal.any((m) => m.direction == direction)) {
      _ghostOverlay.clear();
      return;
    }
    final result = bridge.previewMove(_board, move);
    _ghostOverlay.showPreview(
      baseBoard: _board,
      ghostBoard: result.finalBoard,
    );
    onPreview?.call(direction: direction, ghostBoard: result.finalBoard);
  }

  void clearPreview() {
    _ghostOverlay.clear();
  }

  Future<void> _onDirectionTapped(Direction direction) {
    return commitDirection(direction);
  }

  Future<void> commitDirection(Direction direction) async {
    if (_animating || _won || _stuck || _paused) {
      return;
    }

    _selectedTileId ??= _primaryMovableTileId();
    if (_selectedTileId == null) {
      return;
    }

    final move = Move(tileId: _selectedTileId!, direction: direction);
    final moves = bridge.legalMoves(_board, _selectedTileId!);
    if (!moves.any((m) => m.direction == direction)) {
      return;
    }

    _animating = true;
    _clearSelection();
    _syncSession();

    final (result, newBoard) = bridge.commitMove(_board, move);
    await _animateResult(result);
    _board = newBoard;
    await _boardComponent.updateBoard(_board);
    _boardHistory.add(newBoard);
    _boardForwardHistory.clear();
    _moveRecords.add(
      MoveRecord(tileId: move.tileId, direction: move.direction),
    );
    _movesUsed++;
    _animating = false;
    onMoveCommitted?.call(result, _board);
    _syncSession();

    if (const ObjectiveChecker().isSolved(level, _board)) {
      _won = true;
      _syncSession();
      onLevelWon?.call(_board, _movesUsed, _moveRecords);
    } else if (const StuckDetector().isStuck(level, _board)) {
      _stuck = true;
      _syncSession();
      onLevelStuck?.call(_board, _movesUsed);
    }
  }

  Future<void> _animateResult(SimulationResult result) async {
    if (reduceMotion) {
      final last = result.steps.isNotEmpty
          ? result.steps.last.boardSnapshot
          : result.finalBoard;
      await _boardComponent.updateBoard(last);
      return;
    }

    final delayMs = animationCycleStepMinMs +
        ((animationCycleStepMaxMs - animationCycleStepMinMs) ~/ 2);

    for (final step in result.steps) {
      if (step.actions.isEmpty) {
        continue;
      }
      await _boardComponent.updateBoard(step.boardSnapshot);
      await Future<void>.delayed(Duration(milliseconds: delayMs));
    }
  }

  void undo() {
    if (_animating || _won || _boardHistory.length <= 1) {
      return;
    }

    _stuck = false;
    _boardForwardHistory.add(_boardHistory.last);
    _boardHistory.removeLast();
    if (_moveRecords.isNotEmpty) {
      _moveRecords.removeLast();
    }
    _movesUsed = _movesUsed > 0 ? _movesUsed - 1 : 0;
    _board = _boardHistory.last;
    _boardComponent.updateBoard(_board);
    _clearSelection();
    _syncSession();
  }

  void redo() {
    if (_animating || _won || _boardForwardHistory.isEmpty) {
      return;
    }

    _stuck = false;
    _boardHistory.add(_boardForwardHistory.removeLast());
    _board = _boardHistory.last;
    _boardComponent.updateBoard(_board);
    _movesUsed++;
    _clearSelection();
    _syncSession();
  }

  bool showHint({required int tier}) {
    if (_animating || _won || _stuck || level.solutionMoves.isEmpty) {
      return false;
    }
    if (_movesUsed >= level.solutionMoves.length) {
      return false;
    }

    final direction = DirectionX.fromShortCode(level.solutionMoves[_movesUsed]);
    final tileId = _resolveHintTileId();
    if (direction == null || tileId == null) {
      return false;
    }

    if (tier == 1) {
      _selectedTileId = tileId;
      _selectionOverlay.selectTile(tileId);
      _forceLines.updateVectors(bridge.computeForces(_board, tileId));
      onTileSelected?.call(
        tileId: tileId,
        legalDirections: bridge
            .legalMoves(_board, tileId)
            .map((m) => m.direction)
            .toList(),
      );
      return true;
    }

    final legalDirections = bridge
        .legalMoves(_board, tileId)
        .map((move) => move.direction)
        .toList();
    if (tier == 2) {
      if (!legalDirections.contains(direction)) {
        return false;
      }
      _selectedTileId = tileId;
      _selectionOverlay.showForTile(tileId, [direction]);
      _forceLines.updateVectors(bridge.computeForces(_board, tileId));
      return true;
    }

    // Tier 3 — full move
    if (!legalDirections.contains(direction)) {
      return false;
    }
    _selectedTileId = tileId;
    _selectionOverlay.showForTile(tileId, [direction]);
    _forceLines.updateVectors(bridge.computeForces(_board, tileId));
    return true;
  }

  String? _resolveHintTileId() {
    return _primaryMovableTileId();
  }

  void restart() {
    if (_animating) {
      return;
    }
    setBoard(level.board);
  }

  void clearStuck() {
    _stuck = false;
    _syncSession();
  }

  void setBoard(BoardModel board) {
    _board = board;
    _boardHistory
      ..clear()
      ..add(board);
    _boardForwardHistory.clear();
    _moveRecords.clear();
    _movesUsed = 0;
    _won = false;
    _stuck = false;
    _boardComponent.updateBoard(board);
    _clearSelection();
    _syncSession();
  }

  String? _primaryMovableTileId() {
    final objectiveTileId = level.objective.when(
      position: (tileId, _, _) => tileId,
      sequence: (tileIds, _) => tileIds.isEmpty ? null : tileIds.first,
      sum: (tileIds, _) => tileIds.isEmpty ? null : tileIds.first,
      balance: (regionTileIds, _) =>
          regionTileIds.isEmpty ? null : regionTileIds.first,
      collection: (tileGoals) =>
          tileGoals.isEmpty ? null : tileGoals.keys.first,
      chain: (ids) => ids.isEmpty ? null : ids.first,
    );

    if (objectiveTileId != null) {
      final tile = _board.tileById(objectiveTileId);
      if (tile != null && tile.isMovable) {
        return objectiveTileId;
      }
    }

    for (final tile in _board.tiles) {
      if (tile.isMovable && tile.isNumberTile) {
        return tile.id;
      }
    }
    return null;
  }
}
