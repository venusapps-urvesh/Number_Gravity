import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/board_constants.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

class TileComponent extends PositionComponent with TapCallbacks {
  TileComponent({
    required this.tile,
    required this.colorBlindMode,
    this.onTap,
  }) : super(
          size: Vector2.all(tileSizePx),
          anchor: Anchor.topLeft,
        );

  TileModel tile;
  final bool colorBlindMode;
  final void Function(TileModel tile)? onTap;
  bool selected = false;

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    final radius = Radius.circular(tileCornerRadiusPx);
    final background = _backgroundColor();

    final paint = Paint()..color = background;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);

    if (selected) {
      final border = Paint()
        ..color = AppColors.goal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), border);
    }

    if (colorBlindMode && tile.type == TileType.number && tile.value != 0) {
      _drawSign(canvas, rect);
    }

    final text = _label;
    if (text.isNotEmpty) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(
        canvas,
        Offset(
          (size.x - painter.width) / 2,
          (size.y - painter.height) / 2,
        ),
      );
    }
  }

  String get _label {
    if (tile.type == TileType.goal) {
      return '★';
    }
    if (tile.type == TileType.wall) {
      return '';
    }
    if (tile.type == TileType.portal) {
      return '◎';
    }
    if (tile.type == TileType.multiplier) {
      return '×${tile.modifierFactor}';
    }
    if (tile.type == TileType.divider) {
      return '÷${tile.modifierFactor}';
    }
    if (tile.type == TileType.inverter) {
      return '±';
    }
    if (tile.type == TileType.switchTile) {
      return '⏻';
    }
    if (tile.type == TileType.door) {
      return tile.isDoorOpen ? '▢' : '▣';
    }
    if (tile.value == 0) {
      return '0';
    }
    return tile.value > 0 ? '+${tile.value}' : '${tile.value}';
  }

  Color _backgroundColor() {
    switch (tile.type) {
      case TileType.goal:
        return AppColors.goal;
      case TileType.wall:
        return AppColors.neutral600;
      case TileType.number:
      case TileType.freeze:
        return AppColors.tileColorForValue(tile.value);
      case TileType.portal:
        return AppColors.neutral700;
      case TileType.multiplier:
      case TileType.divider:
      case TileType.inverter:
        return AppColors.neutral500;
      case TileType.switchTile:
      case TileType.door:
        return AppColors.neutral400;
    }
  }

  void _drawSign(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final cx = rect.right - 12;
    final cy = rect.top + 12;
    if (tile.value > 0) {
      canvas.drawLine(Offset(cx, cy - 5), Offset(cx, cy + 5), paint);
      canvas.drawLine(Offset(cx - 5, cy), Offset(cx + 5, cy), paint);
    } else {
      canvas.drawLine(Offset(cx - 5, cy), Offset(cx + 5, cy), paint);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (tile.isMovable) {
      onTap?.call(tile);
    }
  }
}
