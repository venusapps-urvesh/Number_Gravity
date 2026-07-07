import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../layout/board_layout.dart';

/// Draws per-cell grid lines behind tiles.
class GridComponent extends PositionComponent {
  GridComponent({required this.layout});

  BoardLayout layout;

  void updateLayout(BoardLayout newLayout) {
    layout = newLayout;
    size = Vector2(newLayout.boardWidth, newLayout.boardHeight);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = AppColors.neutral400.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final cell = layout.cellSize + layout.gap;

    for (var row = 0; row < layout.rows; row++) {
      for (var col = 0; col < layout.cols; col++) {
        final left = col * cell;
        final top = row * cell;
        final rect = Rect.fromLTWH(
          left,
          top,
          layout.cellSize,
          layout.cellSize,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(layout.cornerRadius * 0.5)),
          paint,
        );
      }
    }
  }
}
