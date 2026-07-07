import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/move.dart';
import 'board_component.dart';

class GameSelectionOverlay extends PositionComponent with TapCallbacks {
  GameSelectionOverlay({
    required this.boardComponent,
    this.onDirectionTapped,
    this.onDirectionPreview,
  });

  final BoardComponent boardComponent;
  final void Function(Direction direction)? onDirectionTapped;
  final void Function(Direction direction)? onDirectionPreview;
  final List<Direction> _legalDirections = [];

  String? _selectedTileId;
  Direction? _previewedDirection;

  void showForTile(String? tileId, List<Direction> directions) {
    _legalDirections
      ..clear()
      ..addAll(directions);
    _previewedDirection = null;
    selectTile(tileId);
  }

  void selectTile(String? tileId) {
    _selectedTileId = tileId;
    boardComponent.setSelectedTile(tileId);
  }

  void clear() {
    _legalDirections.clear();
    _selectedTileId = null;
    _previewedDirection = null;
    boardComponent.setSelectedTile(null);
  }

  double get _cellSize => boardComponent.layout.cellSize;

  @override
  void render(Canvas canvas) {
    if (_legalDirections.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = AppColors.goal.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    for (final direction in _legalDirections) {
      if (_selectedTileId == null) {
        continue;
      }
      final selected = boardComponent.tileComponentFor(_selectedTileId!);
      if (selected == null) {
        continue;
      }

      final center = selected.position + Vector2.all(_cellSize / 2);
      final arrow = _arrowPoints(center, direction);
      final path = Path()
        ..moveTo(arrow.$1.x, arrow.$1.y)
        ..lineTo(arrow.$2.x, arrow.$2.y)
        ..lineTo(arrow.$3.x, arrow.$3.y)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (_selectedTileId == null || _legalDirections.isEmpty) {
      return;
    }
    final local = event.localPosition;
    final selected = boardComponent.tileComponentFor(_selectedTileId!);
    if (selected == null) {
      return;
    }
    final center = selected.position + Vector2.all(_cellSize / 2);
    final dx = local.x - center.x;
    final dy = local.y - center.y;

    Direction? tapped;
    if (dx.abs() > dy.abs()) {
      tapped = dx > 0 ? Direction.right : Direction.left;
    } else if (dy.abs() > 8) {
      tapped = dy > 0 ? Direction.down : Direction.up;
    }

    if (tapped == null || !_legalDirections.contains(tapped)) {
      return;
    }

    if (_previewedDirection == tapped) {
      onDirectionTapped?.call(tapped);
      _previewedDirection = null;
      return;
    }

    _previewedDirection = tapped;
    onDirectionPreview?.call(tapped);
  }

  (Vector2, Vector2, Vector2) _arrowPoints(
    Vector2 center,
    Direction direction,
  ) {
    final offset = _cellSize * 0.55;
    const size = 10.0;
    return switch (direction) {
      Direction.up => (
        Vector2(center.x, center.y - offset),
        Vector2(center.x - size, center.y - offset + size),
        Vector2(center.x + size, center.y - offset + size),
      ),
      Direction.down => (
        Vector2(center.x, center.y + offset),
        Vector2(center.x - size, center.y + offset - size),
        Vector2(center.x + size, center.y + offset - size),
      ),
      Direction.left => (
        Vector2(center.x - offset, center.y),
        Vector2(center.x - offset + size, center.y - size),
        Vector2(center.x - offset + size, center.y + size),
      ),
      Direction.right => (
        Vector2(center.x + offset, center.y),
        Vector2(center.x + offset - size, center.y - size),
        Vector2(center.x + offset - size, center.y + size),
      ),
    };
  }
}
