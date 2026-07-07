import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/board_model.dart';
import '../../models/move.dart';
import '../../models/tile_model.dart';
import '../animation/tile_effects.dart';
import '../layout/board_layout.dart';
import 'grid_component.dart';
import 'tile_component.dart';

class BoardComponent extends PositionComponent {
  BoardComponent({
    required this.board,
    required BoardLayout layout,
    this.onTileTapped,
    this.onTileSwiped,
    this.colorBlindMode = false,
  })  : layout = layout,
        super(anchor: Anchor.topLeft);

  BoardModel board;
  BoardLayout layout;
  final void Function(TileModel tile)? onTileTapped;
  final void Function(TileModel tile, Direction direction)? onTileSwiped;
  final bool colorBlindMode;

  final Map<String, TileComponent> _tileComponents = {};
  GridComponent? _gridComponent;

  double get boardWidth => layout.boardWidth;

  double get boardHeight => layout.boardHeight;

  @override
  Future<void> onLoad() async {
    size = Vector2(boardWidth, boardHeight);
    _gridComponent = GridComponent(layout: layout);
    await add(_gridComponent!);
    await _syncTiles();
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    final paint = Paint()
      ..color = AppColors.neutral200.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(layout.cornerRadius)),
      paint,
    );
    super.render(canvas);
  }

  Future<void> updateLayout(BoardLayout newLayout) async {
    layout = newLayout;
    size = Vector2(boardWidth, boardHeight);
    _gridComponent?.updateLayout(newLayout);
    await _syncTiles();
  }

  Future<void> updateBoard(BoardModel newBoard) async {
    board = newBoard;
    await _syncTiles();
  }

  Future<void> _syncTiles() async {
    final existingIds = board.tiles.map((t) => t.id).toSet();
    final toRemove =
        _tileComponents.keys.where((id) => !existingIds.contains(id)).toList();
    for (final id in toRemove) {
      _tileComponents[id]?.removeFromParent();
      _tileComponents.remove(id);
    }

    for (final tile in board.tiles) {
      final position = _cellPosition(tile.row, tile.col);
      final existing = _tileComponents[tile.id];
      if (existing != null) {
        existing
          ..tile = tile
          ..position = position
          ..updateCellSize(layout.cellSize);
      } else {
        final component = TileComponent(
          tile: tile,
          cellSize: layout.cellSize,
          cornerRadius: layout.cornerRadius,
          fontSize: layout.fontSize,
          colorBlindMode: colorBlindMode,
          onTap: onTileTapped,
          onSwipe: onTileSwiped,
        )..position = position;
        _tileComponents[tile.id] = component;
        await add(component);
      }
    }
  }

  Vector2 _cellPosition(int row, int col) {
    final cell = layout.cellSize + layout.gap;
    return Vector2(col * cell, row * cell);
  }

  void setSelectedTile(String? tileId) {
    for (final entry in _tileComponents.entries) {
      final isSelected = entry.key == tileId;
      entry.value.selected = isSelected;
      playSelectionScale(entry.value, selected: isSelected);
    }
  }

  TileComponent? tileComponentFor(String tileId) => _tileComponents[tileId];

  Vector2 cellCenter(int row, int col) {
    final topLeft = _cellPosition(row, col);
    return topLeft + Vector2.all(layout.cellSize / 2);
  }

  Vector2 cellTopLeft(int row, int col) => _cellPosition(row, col);
}
