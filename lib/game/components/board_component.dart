import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/board_constants.dart';
import '../../models/board_model.dart';
import '../../models/tile_model.dart';
import 'tile_component.dart';

class BoardComponent extends PositionComponent {
  BoardComponent({
    required this.board,
    this.onTileTapped,
    this.colorBlindMode = false,
  }) : super(anchor: Anchor.topLeft);

  BoardModel board;
  final void Function(TileModel tile)? onTileTapped;
  final bool colorBlindMode;

  final Map<String, TileComponent> _tileComponents = {};

  double get boardWidth =>
      board.cols * (tileSizePx + boardCellGapPx) - boardCellGapPx;

  double get boardHeight =>
      board.rows * (tileSizePx + boardCellGapPx) - boardCellGapPx;

  @override
  Future<void> onLoad() async {
    size = Vector2(boardWidth, boardHeight);
    await _syncTiles();
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    final paint = Paint()
      ..color = AppColors.neutral200.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      paint,
    );
    super.render(canvas);
  }

  Future<void> updateBoard(BoardModel newBoard) async {
    board = newBoard;
    size = Vector2(boardWidth, boardHeight);
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
          ..selected = false;
      } else {
        final component = TileComponent(
          tile: tile,
          colorBlindMode: colorBlindMode,
          onTap: onTileTapped,
        )..position = position;
        _tileComponents[tile.id] = component;
        await add(component);
      }
    }
  }

  Vector2 _cellPosition(int row, int col) {
    final cell = tileSizePx + boardCellGapPx;
    return Vector2(col * cell, row * cell);
  }

  void setSelectedTile(String? tileId) {
    for (final entry in _tileComponents.entries) {
      entry.value.selected = entry.key == tileId;
    }
  }

  TileComponent? tileComponentFor(String tileId) => _tileComponents[tileId];

  Vector2 cellCenter(int row, int col) {
    final topLeft = _cellPosition(row, col);
    return topLeft + Vector2.all(tileSizePx / 2);
  }

  Vector2 cellTopLeft(int row, int col) => _cellPosition(row, col);
}
