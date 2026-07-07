import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/board_model.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';
import 'board_component.dart';

/// Renders translucent ghost tiles for move preview (Section 10.1).
class GhostOverlayComponent extends Component {
  GhostOverlayComponent({required this.boardComponent});

  final BoardComponent boardComponent;
  BoardModel? _ghostBoard;
  BoardModel? _baseBoard;

  void showPreview({
    required BoardModel baseBoard,
    required BoardModel ghostBoard,
  }) {
    _baseBoard = baseBoard;
    _ghostBoard = ghostBoard;
  }

  void clear() {
    _ghostBoard = null;
    _baseBoard = null;
  }

  double get _cellSize => boardComponent.layout.cellSize;

  double get _cornerRadius => boardComponent.layout.cornerRadius;

  @override
  void render(Canvas canvas) {
    final ghost = _ghostBoard;
    final base = _baseBoard;
    if (ghost == null || base == null) {
      return;
    }

    for (final tile in ghost.tiles) {
      if (!tile.isMovable || tile.type != TileType.number) {
        continue;
      }
      final baseTile = base.tileById(tile.id);
      if (baseTile != null &&
          baseTile.row == tile.row &&
          baseTile.col == tile.col) {
        continue;
      }
      _drawGhostTile(canvas, tile);
    }
  }

  void _drawGhostTile(Canvas canvas, TileModel tile) {
    final topLeft = boardComponent.cellTopLeft(tile.row, tile.col);
    final rect = Rect.fromLTWH(
      topLeft.x,
      topLeft.y,
      _cellSize,
      _cellSize,
    );
    final radius = Radius.circular(_cornerRadius);

    final fill = Paint()
      ..color = AppColors.positive.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), fill);

    final border = Paint()
      ..color = AppColors.positive.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), border);

    if (tile.value != 0) {
      final fontSize = boardComponent.layout.fontSize;
      final painter = TextPainter(
        text: TextSpan(
          text: tile.value > 0 ? '+${tile.value}' : '${tile.value}',
          style: TextStyle(
            color: AppColors.positive.withValues(alpha: 0.7),
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        Offset(
          rect.center.dx - painter.width / 2,
          rect.center.dy - painter.height / 2,
        ),
      );
    }
  }
}
