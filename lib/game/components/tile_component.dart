import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/move.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';
import '../../widgets/common/goal_star_icon.dart';

class TileComponent extends PositionComponent with TapCallbacks, DragCallbacks {
  TileComponent({
    required this.tile,
    required this.cellSize,
    required this.cornerRadius,
    required this.fontSize,
    required this.colorBlindMode,
    this.onTap,
    this.onSwipe,
  }) : super(
          size: Vector2.all(cellSize),
          anchor: Anchor.topLeft,
        );

  TileModel tile;
  final double cellSize;
  final double cornerRadius;
  final double fontSize;
  final bool colorBlindMode;
  final void Function(TileModel tile)? onTap;
  final void Function(TileModel tile, Direction direction)? onSwipe;
  bool selected = false;
  bool glowing = false;
  Vector2? _dragStart;
  Vector2? _dragLast;

  void updateCellSize(double newSize) {
    size = Vector2.all(newSize);
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    final radius = Radius.circular(cornerRadius);
    final background = _backgroundColor();

    final paint = Paint()..color = background;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);

    if (glowing) {
      final glow = Paint()
        ..color = AppColors.goal.withValues(alpha: 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.inflate(4), radius),
        glow,
      );
    }

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

    if (tile.type == TileType.goal) {
      paintGoalStar(canvas, rect.deflate(rect.shortestSide * 0.28));
      return;
    }

    if (tile.type == TileType.portal) {
      _drawPortal(canvas, rect);
      return;
    }

    if (tile.type == TileType.switchTile) {
      _drawPowerIcon(canvas, rect);
      return;
    }

    if (tile.type == TileType.door) {
      _drawDoor(canvas, rect, tile.isDoorOpen);
      return;
    }

    final text = _label;
    if (text.isNotEmpty) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
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
    if (tile.type == TileType.wall) {
      return '';
    }
    if (tile.type == TileType.multiplier) {
      return 'x${tile.modifierFactor}';
    }
    if (tile.type == TileType.divider) {
      return '/${tile.modifierFactor}';
    }
    if (tile.type == TileType.inverter) {
      return '+/-';
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
    final cx = rect.right - cellSize * 0.18;
    final cy = rect.top + cellSize * 0.18;
    if (tile.value > 0) {
      canvas.drawLine(Offset(cx, cy - 5), Offset(cx, cy + 5), paint);
      canvas.drawLine(Offset(cx - 5, cy), Offset(cx + 5, cy), paint);
    } else {
      canvas.drawLine(Offset(cx - 5, cy), Offset(cx + 5, cy), paint);
    }
  }

  void _drawPortal(Canvas canvas, Rect rect) {
    final center = rect.center;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, rect.shortestSide * 0.18, paint);
    canvas.drawCircle(center, rect.shortestSide * 0.1, paint);
  }

  void _drawPowerIcon(Canvas canvas, Rect rect) {
    final center = rect.center;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, rect.shortestSide * 0.14, paint);
    canvas.drawLine(
      center,
      Offset(center.dx, rect.top + rect.height * 0.22),
      paint,
    );
  }

  void _drawDoor(Canvas canvas, Rect rect, bool open) {
    final inset = rect.deflate(rect.shortestSide * 0.28);
    final paint = Paint()
      ..color = Colors.white
      ..style = open ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = 2.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(inset, const Radius.circular(4)),
      paint,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (tile.isMovable) {
      onTap?.call(tile);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _dragStart = event.canvasPosition;
    _dragLast = event.canvasPosition;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _dragLast = event.canvasEndPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    final start = _dragStart;
    final end = _dragLast;
    _dragStart = null;
    _dragLast = null;
    if (start == null || !tile.isMovable) {
      return;
    }
    if (end == null) {
      return;
    }

    final dx = end.x - start.x;
    final dy = end.y - start.y;
    final threshold = cellSize * 0.22;

    Direction? direction;
    if (dx.abs() >= dy.abs() && dx.abs() > threshold) {
      direction = dx > 0 ? Direction.right : Direction.left;
    } else if (dy.abs() > threshold) {
      direction = dy > 0 ? Direction.down : Direction.up;
    }

    if (direction != null) {
      onSwipe?.call(tile, direction);
    }
  }
}
