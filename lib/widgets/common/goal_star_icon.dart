import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Vector goal star — replaces unicode star characters for iOS compatibility.
class GoalStarIcon extends StatelessWidget {
  const GoalStarIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _GoalStarPainter(color: color),
    );
  }
}

class _GoalStarPainter extends CustomPainter {
  _GoalStarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    const points = 5;
    final outerRadius = size.shortestSide / 2;
    final innerRadius = outerRadius * 0.45;
    final center = Offset(size.width / 2, size.height / 2);

    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * math.pi / points) - math.pi / 2;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);

    final glow = Paint()
      ..color = AppColors.goal.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, glow);
  }

  @override
  bool shouldRepaint(covariant _GoalStarPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/// Canvas helper for Flame tile rendering.
void paintGoalStar(Canvas canvas, Rect rect, {Color color = Colors.white}) {
  final size = math.min(rect.width, rect.height) * 0.5;
  final center = rect.center;
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  final path = Path();
  const points = 5;
  final outerRadius = size / 2;
  final innerRadius = outerRadius * 0.45;

  for (var i = 0; i < points * 2; i++) {
    final radius = i.isEven ? outerRadius : innerRadius;
    final angle = (i * math.pi / points) - math.pi / 2;
    final point = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
    if (i == 0) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
  }
  path.close();
  canvas.drawPath(path, paint);
}
