import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/board_constants.dart';
import '../../models/tile_type.dart';
import '../common/goal_star_icon.dart';

class TileBadge extends StatelessWidget {
  const TileBadge({
    required this.value,
    required this.type,
    super.key,
    this.colorBlindMode = false,
    this.size = tileSizePx,
    this.selected = false,
  });

  final int value;
  final TileType type;
  final bool colorBlindMode;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final background = _backgroundColor();
    final borderColor = selected ? AppColors.goal : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(tileCornerRadiusPx),
        border: Border.all(
          color: borderColor,
          width: selected ? 3 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: background.withValues(alpha: 0.35),
            blurRadius: selected ? 12 : 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (colorBlindMode && type == TileType.number)
            Positioned(
              top: 6,
              right: 6,
              child: _SignShape(value: value),
            ),
          if (type == TileType.goal)
            GoalStarIcon(size: size * 0.42)
          else
            Text(
              _label,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.34,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  String get _label {
    if (type == TileType.wall) {
      return '';
    }
    if (value == 0) {
      return '0';
    }
    return value > 0 ? '+$value' : '$value';
  }

  Color _backgroundColor() {
    switch (type) {
      case TileType.goal:
        return AppColors.goal;
      case TileType.wall:
        return AppColors.neutral600;
      case TileType.number:
      case TileType.freeze:
        return AppColors.tileColorForValue(value);
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
}

class _SignShape extends StatelessWidget {
  const _SignShape({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
    }

    return CustomPaint(
      size: const Size(12, 12),
      painter: _SignPainter(isPositive: value > 0),
    );
  }
}

class _SignPainter extends CustomPainter {
  _SignPainter({required this.isPositive});

  final bool isPositive;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (isPositive) {
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SignPainter oldDelegate) {
    return oldDelegate.isPositive != isPositive;
  }
}
