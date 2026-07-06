import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../models/board_model.dart';
import '../../models/move.dart';
import '../../models/simulation/simulation_result.dart';
import '../../models/tile_model.dart';
import 'bridges/simulation_bridge.dart';
import 'components/board_component.dart';
import 'components/force_line_component.dart';
import 'components/game_selection_overlay.dart';

typedef MoveCommitCallback = void Function(
  SimulationResult result,
  BoardModel board,
);

class NumberGravityGame extends FlameGame {
  NumberGravityGame({
    required this.bridge,
    required BoardModel initialBoard,
    this.colorBlindMode = false,
    this.onMoveCommitted,
  }) : _board = initialBoard;

  final SimulationBridge bridge;
  final bool colorBlindMode;
  final MoveCommitCallback? onMoveCommitted;

  BoardModel _board;
  String? _selectedTileId;
  late BoardComponent _boardComponent;
  late GameSelectionOverlay _selectionOverlay;
  late ForceLineComponent _forceLines;
  bool _animating = false;

  BoardModel get board => _board;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

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

    // FlameGame already owns a World wired to the camera; add board there.
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

  void _onTileTapped(TileModel tile) {
    if (_animating) {
      return;
    }
    _selectedTileId = tile.id;
    final moves = bridge.legalMoves(_board, tile.id);
    _selectionOverlay.showForTile(tile.id, moves.map((m) => m.direction).toList());
    _forceLines.updateVectors(bridge.computeForces(_board, tile.id));
  }

  Future<void> commitDirection(Direction direction) async {
    if (_animating || _selectedTileId == null) {
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
    _selectedTileId = null;
    _animating = false;
    onMoveCommitted?.call(result, _board);
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

  void setBoard(BoardModel board) {
    _board = board;
    _boardComponent.updateBoard(board);
    _selectionOverlay.clear();
    _forceLines.updateVectors(const []);
    _selectedTileId = null;
  }
}
