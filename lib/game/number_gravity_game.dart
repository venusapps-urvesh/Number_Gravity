import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/objective/objective_model.dart';
import '../../models/replay/move_record.dart';
import '../../models/simulation/force_vector.dart';
import '../../models/simulation/simulation_result.dart';
import '../../models/tile_model.dart';
import '../../simulation/objective_checker.dart';
import '../../simulation/stuck_detector.dart';
import 'animation/simulation_animator.dart';
import 'bridges/simulation_bridge.dart';
import 'components/board_component.dart';
import 'components/force_line_component.dart';
import 'components/game_selection_overlay.dart';
import 'components/ghost_overlay_component.dart';
import 'layout/board_layout.dart';

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
  required List<ForceVector> forces,
});

typedef PreviewCallback = void Function({
  required Direction direction,
  required BoardModel ghostBoard,
});

class _HistoryEntry {
  const _HistoryEntry({
    required this.board,
    this.selectedTileId,
    required this.movesUsed,
    required this.moveRecords,
  });

  final BoardModel board;
  final String? selectedTileId;
  final int movesUsed;
  final List<MoveRecord> moveRecords;
}

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
  })  : _board = level.board,
        _layout = BoardLayout.defaultFor(
          rows: level.board.rows,
          cols: level.board.cols,
        );

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
  BoardLayout _layout;
  final List<_HistoryEntry> _history = [];
  final List<_HistoryEntry> _forwardHistory = [];
  int _movesUsed = 0;
  String? _selectedTileId;
  late BoardComponent _boardComponent;
  late GameSelectionOverlay _selectionOverlay;
  late ForceLineComponent _forceLines;
  late GhostOverlayComponent _ghostOverlay;
  late SimulationAnimator _animator;
  PositionComponent? _boardRoot;
  bool _animating = false;
  bool _won = false;
  bool _stuck = false;
  bool _paused = false;
  bool _loaded = false;
  double _viewportWidth = 0;
  double _viewportHeight = 0;

  BoardModel get board => _board;
  BoardLayout get displayLayout => _layout;
  bool get canUndo => _history.length > 1;
  bool get canRedo => _forwardHistory.isNotEmpty;
  int get movesUsed => _movesUsed;
  bool get isAnimating => _animating;
  bool get isWon => _won;
  bool get isStuck => _stuck;
  List<MoveRecord> get moveRecords =>
      List.unmodifiable(_currentEntry.moveRecords);

  _HistoryEntry get _currentEntry => _history.last;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _pushHistory(_board, selectedTileId: null, movesUsed: 0, moveRecords: []);
    await _buildBoardScene();
    _loaded = true;
    if (_viewportWidth > 0 && _viewportHeight > 0) {
      _applyViewport(_viewportWidth, _viewportHeight);
    } else {
      _updateCamera();
    }
    _syncSession();
  }

  /// Called when Flame reports the game surface size (matches GameWidget box).
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (size.x <= 0 || size.y <= 0) {
      return;
    }
    final fitted = BoardLayout.fit(
      rows: level.board.rows,
      cols: level.board.cols,
      maxWidth: size.x,
      maxHeight: size.y,
    );
    if (fitted == _layout) {
      _updateCamera();
      return;
    }
    _layout = fitted;
    if (_loaded) {
      _boardComponent.updateLayout(_layout);
      _selectionOverlay.size = Vector2(_layout.boardWidth, _layout.boardHeight);
      _boardRoot?.size = Vector2(_layout.boardWidth, _layout.boardHeight);
    }
    _updateCamera();
  }

  Future<void> _buildBoardScene() async {
    _boardComponent = BoardComponent(
      board: _board,
      layout: _layout,
      colorBlindMode: colorBlindMode,
      onTileTapped: _onTileTapped,
      onTileSwiped: _onTileSwiped,
    );
    _selectionOverlay = GameSelectionOverlay(
      boardComponent: _boardComponent,
      onDirectionTapped: _onDirectionTapped,
      onDirectionPreview: previewDirection,
    );
    _forceLines = ForceLineComponent(boardComponent: _boardComponent);
    _ghostOverlay = GhostOverlayComponent(boardComponent: _boardComponent);
    _animator = SimulationAnimator(
      boardComponent: _boardComponent,
      level: level,
      reduceMotion: reduceMotion,
    );

    _boardRoot = PositionComponent(
      position: Vector2.zero(),
      size: Vector2(_layout.boardWidth, _layout.boardHeight),
    )
      ..add(_boardComponent)
      ..add(_ghostOverlay)
      ..add(_forceLines)
      ..add(_selectionOverlay);

    _selectionOverlay.size = Vector2(_layout.boardWidth, _layout.boardHeight);
    await world.add(_boardRoot!);
  }

  /// Recomputes cell size from viewport constraints and centers the board.
  void applyLayout({
    required double viewportWidth,
    required double viewportHeight,
  }) {
    _viewportWidth = viewportWidth;
    _viewportHeight = viewportHeight;
    if (!_loaded) {
      return;
    }
    _applyViewport(viewportWidth, viewportHeight);
  }

  void _applyViewport(double viewportWidth, double viewportHeight) {
    final newLayout = BoardLayout.fit(
      rows: level.board.rows,
      cols: level.board.cols,
      maxWidth: viewportWidth,
      maxHeight: viewportHeight,
    );
    if (newLayout == _layout) {
      _updateCamera();
      return;
    }

    _layout = newLayout;
    _boardComponent.updateLayout(_layout);
    _selectionOverlay.size = Vector2(_layout.boardWidth, _layout.boardHeight);
    _boardRoot?.size = Vector2(_layout.boardWidth, _layout.boardHeight);
    _updateCamera();
  }

  void _updateCamera() {
    final resolution = Vector2(_layout.boardWidth, _layout.boardHeight);
    camera.viewport = FixedResolutionViewport(resolution: resolution);
    camera.viewfinder.position = resolution / 2;
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

  void _replaceCurrentHistorySelection(String? tileId) {
    if (_history.isEmpty) {
      return;
    }
    final last = _history.removeLast();
    _history.add(
      _HistoryEntry(
        board: last.board,
        selectedTileId: tileId,
        movesUsed: last.movesUsed,
        moveRecords: last.moveRecords,
      ),
    );
  }

  void _pushHistory(
    BoardModel board, {
    required String? selectedTileId,
    required int movesUsed,
    required List<MoveRecord> moveRecords,
  }) {
    _history.add(
      _HistoryEntry(
        board: board,
        selectedTileId: selectedTileId,
        movesUsed: movesUsed,
        moveRecords: List.unmodifiable(moveRecords),
      ),
    );
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

  void _restoreSelection(String? tileId) {
    if (tileId == null) {
      _clearSelection();
      return;
    }
    final tile = _board.tileById(tileId);
    if (tile == null || !tile.isMovable) {
      _clearSelection();
      return;
    }
    _selectedTileId = tileId;
    final directions = bridge
        .legalMoves(_board, tileId)
        .map((move) => move.direction)
        .toList();
    _selectionOverlay.showForTile(tileId, directions);
    _forceLines.updateVectors(bridge.computeForces(_board, tileId));
    onTileSelected?.call(
      tileId: tileId,
      legalDirections: directions,
      forces: bridge.computeForces(_board, tileId),
    );
  }

  void _onTileTapped(TileModel tile) {
    if (_animating || _won || _stuck || _paused || !tile.isMovable) {
      return;
    }
    _selectedTileId = tile.id;
    _replaceCurrentHistorySelection(tile.id);
    final directions = bridge
        .legalMoves(_board, tile.id)
        .map((move) => move.direction)
        .toList();
    final forces = bridge.computeForces(_board, tile.id);
    _selectionOverlay.showForTile(tile.id, directions);
    _forceLines.updateVectors(forces);
    onTileSelected?.call(
      tileId: tile.id,
      legalDirections: directions,
      forces: forces,
    );
    _syncSession();
  }

  void _onTileSwiped(TileModel tile, Direction direction) {
    if (_animating || _won || _stuck || _paused || !tile.isMovable) {
      return;
    }
    _selectedTileId = tile.id;
    _replaceCurrentHistorySelection(tile.id);
    unawaited(commitDirection(direction));
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
    await _animator.animate(result);
    _board = newBoard;
    await _boardComponent.updateBoard(_board);

    final newRecords = [
      ..._currentEntry.moveRecords,
      MoveRecord(tileId: move.tileId, direction: move.direction),
    ];
    _movesUsed++;
    _forwardHistory.clear();
    _pushHistory(
      newBoard,
      selectedTileId: null,
      movesUsed: _movesUsed,
      moveRecords: newRecords,
    );

    _animating = false;
    onMoveCommitted?.call(result, _board);
    _syncSession();

    if (const ObjectiveChecker().isSolved(level, _board)) {
      _won = true;
      _syncSession();
      onLevelWon?.call(_board, _movesUsed, moveRecords);
    } else if (const StuckDetector().isStuck(level, _board)) {
      _stuck = true;
      _syncSession();
      onLevelStuck?.call(_board, _movesUsed);
    }
  }

  void undo() {
    if (_animating || _won || _history.length <= 1) {
      return;
    }

    _stuck = false;
    _forwardHistory.add(_history.removeLast());
    final entry = _history.last;
    _board = entry.board;
    _movesUsed = entry.movesUsed;
    _boardComponent.updateBoard(_board);
    _restoreSelection(entry.selectedTileId);
    _syncSession();
  }

  void redo() {
    if (_animating || _won || _forwardHistory.isEmpty) {
      return;
    }

    _stuck = false;
    final entry = _forwardHistory.removeLast();
    _board = entry.board;
    _movesUsed = entry.movesUsed;
    _pushHistory(
      entry.board,
      selectedTileId: entry.selectedTileId,
      movesUsed: entry.movesUsed,
      moveRecords: entry.moveRecords,
    );
    _boardComponent.updateBoard(_board);
    _restoreSelection(entry.selectedTileId);
    _syncSession();

    if (const ObjectiveChecker().isSolved(level, _board)) {
      _won = true;
      _syncSession();
      onLevelWon?.call(_board, _movesUsed, moveRecords);
    } else if (const StuckDetector().isStuck(level, _board)) {
      _stuck = true;
      _syncSession();
      onLevelStuck?.call(_board, _movesUsed);
    }
  }

  Future<bool> showHint({required int tier}) async {
    if (_animating || _won || _stuck) {
      return false;
    }

    final hintMove = _resolveHintMove();
    if (hintMove == null) {
      return false;
    }
    final tileId = hintMove.tileId;
    final direction = hintMove.direction;

    if (tier == 1) {
      _selectedTileId = tileId;
      _selectionOverlay.selectTile(tileId);
      final forces = bridge.computeForces(_board, tileId);
      _forceLines.updateVectors(forces);
      onTileSelected?.call(
        tileId: tileId,
        legalDirections: bridge
            .legalMoves(_board, tileId)
            .map((m) => m.direction)
            .toList(),
        forces: forces,
      );
      return true;
    }

    final legalDirections = bridge
        .legalMoves(_board, tileId)
        .map((move) => move.direction)
        .toList();
    if (!legalDirections.contains(direction)) {
      return false;
    }

    if (tier == 2) {
      _selectedTileId = tileId;
      _selectionOverlay.showForTile(tileId, [direction]);
      _forceLines.updateVectors(bridge.computeForces(_board, tileId));
      return true;
    }

    _selectedTileId = tileId;
    await commitDirection(direction);
    return true;
  }

  String? _resolveHintTileId() => _primaryMovableTileId();

  Move? _resolveHintMove() {
    final scriptedDirection = _movesUsed < level.solutionMoves.length
        ? DirectionX.fromShortCode(level.solutionMoves[_movesUsed])
        : null;
    final preferredTileId = _selectedTileId ?? _resolveHintTileId();

    if (scriptedDirection != null && preferredTileId != null) {
      final preferredMoves = bridge.legalMoves(_board, preferredTileId);
      if (preferredMoves.any((m) => m.direction == scriptedDirection)) {
        return Move(tileId: preferredTileId, direction: scriptedDirection);
      }
    }

    if (preferredTileId != null) {
      final preferredMoves = bridge.legalMoves(_board, preferredTileId);
      if (preferredMoves.isNotEmpty) {
        return preferredMoves.first;
      }
    }

    for (final tile in _board.tiles) {
      if (!tile.isMovable) {
        continue;
      }
      final legal = bridge.legalMoves(_board, tile.id);
      if (legal.isNotEmpty) {
        return legal.first;
      }
    }
    return null;
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
    _history
      ..clear()
      ..add(
        _HistoryEntry(
          board: board,
          selectedTileId: null,
          movesUsed: 0,
          moveRecords: const [],
        ),
      );
    _forwardHistory.clear();
    _movesUsed = 0;
    _won = false;
    _stuck = false;
    _boardComponent.updateBoard(board);
    _clearSelection();
    _syncSession();
  }

  String? _primaryMovableTileId() {
    final objectiveTileId = switch (level.objective) {
      PositionObjective(:final tileId) => tileId,
      SequenceObjective(:final tileIds) => tileIds.isEmpty ? null : tileIds.first,
      SumObjective(:final tileIds) => tileIds.isEmpty ? null : tileIds.first,
      BalanceObjective(:final regionTileIds) =>
        regionTileIds.isEmpty ? null : regionTileIds.first,
      CollectionObjective(:final tileGoals) =>
        tileGoals.isEmpty ? null : tileGoals.keys.first,
      ChainObjective(:final subObjectiveIds) =>
        subObjectiveIds.isEmpty ? null : subObjectiveIds.first,
    };

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
