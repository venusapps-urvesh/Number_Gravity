import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/replay/move_record.dart';
import '../../models/simulation/simulation_result.dart';
import '../../models/tile_model.dart';
import '../../simulation/objective_checker.dart';
import 'bridges/simulation_bridge.dart';
import 'components/board_component.dart';
import 'components/force_line_component.dart';
import 'components/game_selection_overlay.dart';

typedef MoveCommitCallback = void Function(
  SimulationResult result,
  BoardModel board,
);

typedef LevelWonCallback = void Function(
  BoardModel board,
  int movesUsed,
  List<MoveRecord> moveRecords,
);

class NumberGravityGame extends FlameGame {
  NumberGravityGame({
    required this.bridge,
    required this.level,
    this.colorBlindMode = false,
    this.onMoveCommitted,
    this.onLevelWon,
  }) : _board = level.board;

  final SimulationBridge bridge;
  final LevelModel level;
  final bool colorBlindMode;
  final MoveCommitCallback? onMoveCommitted;
  final LevelWonCallback? onLevelWon;

  BoardModel _board;
  final List<BoardModel> _boardHistory = [];
  final List<MoveRecord> _moveRecords = [];
  int _movesUsed = 0;
  String? _selectedTileId;
  late BoardComponent _boardComponent;
  late GameSelectionOverlay _selectionOverlay;
  late ForceLineComponent _forceLines;
  bool _animating = false;
  bool _won = false;
  bool _paused = false;

  BoardModel get board => _board;
  bool get canUndo => _boardHistory.length > 1;
  int get movesUsed => _movesUsed;
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
    _selectionOverlay = GameSelectionOverlay(boardComponent: _boardComponent);
    _forceLines = ForceLineComponent(boardComponent: _boardComponent);

    const boardPadding = 16.0;
    final boardRoot = PositionComponent(position: Vector2.all(boardPadding))
      ..add(_boardComponent)
      ..add(_forceLines)
      ..add(_selectionOverlay);

    await world.add(boardRoot);

    final resolution = Vector2(
      _boardComponent.boardWidth + boardPadding * 2,
      _boardComponent.boardHeight + boardPadding * 2,
    );
    camera.viewport = FixedResolutionViewport(resolution: resolution);
    camera.viewfinder
      ..anchor = Anchor.center
      ..position = resolution / 2;
  }

  void setPaused(bool paused) {
    _paused = paused;
    if (paused) {
      _selectionOverlay.clear();
      _forceLines.updateVectors(const []);
      _selectedTileId = null;
    }
  }

  void _onTileTapped(TileModel tile) {
    if (_animating || _won || _paused) {
      return;
    }
    _selectedTileId = tile.id;
    final moves = bridge.legalMoves(_board, tile.id);
    _selectionOverlay.showForTile(tile.id, moves.map((m) => m.direction).toList());
    _forceLines.updateVectors(bridge.computeForces(_board, tile.id));
  }

  Future<void> commitDirection(Direction direction) async {
    if (_animating || _won || _paused) {
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
    _selectionOverlay.clear();
    _forceLines.updateVectors(const []);

    final (result, newBoard) = bridge.commitMove(_board, move);
    await _animateResult(result);
    _board = newBoard;
    await _boardComponent.updateBoard(_board);
    _boardHistory.add(newBoard);
    _moveRecords.add(
      MoveRecord(tileId: move.tileId, direction: move.direction),
    );
    _movesUsed++;
    _selectedTileId = null;
    _animating = false;
    onMoveCommitted?.call(result, _board);

    if (const ObjectiveChecker().isSolved(level, _board)) {
      _won = true;
      onLevelWon?.call(_board, _movesUsed, _moveRecords);
    }
  }

  Future<void> _animateResult(SimulationResult result) async {
    for (final step in result.steps) {
      if (step.actions.isEmpty) {
        continue;
      }
      await _boardComponent.updateBoard(step.boardSnapshot);
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }

  void undo() {
    if (_animating || _won || _boardHistory.length <= 1) {
      return;
    }

    _boardHistory.removeLast();
    if (_moveRecords.isNotEmpty) {
      _moveRecords.removeLast();
    }
    _movesUsed = _movesUsed > 0 ? _movesUsed - 1 : 0;
    _board = _boardHistory.last;
    _boardComponent.updateBoard(_board);
    _selectionOverlay.clear();
    _forceLines.updateVectors(const []);
    _selectedTileId = null;
  }

  bool showHint() {
    if (_animating || _won || level.solutionMoves.isEmpty) {
      return false;
    }
    if (_movesUsed >= level.solutionMoves.length) {
      return false;
    }

    final direction = DirectionX.fromShortCode(level.solutionMoves[_movesUsed]);
    final tileId = _primaryMovableTileId();
    if (direction == null || tileId == null) {
      return false;
    }

    final legalDirections = bridge
        .legalMoves(_board, tileId)
        .map((move) => move.direction)
        .toList();
    if (!legalDirections.contains(direction)) {
      return false;
    }

    _selectedTileId = tileId;
    _selectionOverlay.showForTile(tileId, [direction]);
    _forceLines.updateVectors(bridge.computeForces(_board, tileId));
    return true;
  }

  void restart() {
    if (_animating) {
      return;
    }
    setBoard(level.board);
  }

  void setBoard(BoardModel board) {
    _board = board;
    _boardHistory
      ..clear()
      ..add(board);
    _moveRecords.clear();
    _movesUsed = 0;
    _won = false;
    _boardComponent.updateBoard(board);
    _selectionOverlay.clear();
    _forceLines.updateVectors(const []);
    _selectedTileId = null;
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
      chain: (_) => null,
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
