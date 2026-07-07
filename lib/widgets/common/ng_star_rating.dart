import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGStarRating extends StatelessWidget {
  const NGStarRating({
    required this.stars,
    super.key,
    this.maxStars = 3,
    this.size = 48,
    this.spacing = 8,
    this.color,
  });

  final int stars;
  final int maxStars;
  final double size;
  final double spacing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        final earned = index < stars;
        return Padding(
          padding: EdgeInsets.only(right: index < maxStars - 1 ? spacing : 0),
          child: Icon(
            earned ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: earned
                ? (color ?? AppColors.goal)
                : (isDark ? AppColors.neutral600 : AppColors.neutral300),
          ),
        );
      }),
    );
  }
}

class NGStarCount extends StatelessWidget {
  const NGStarCount({
    required this.earned,
    required this.total,
    super.key,
    this.iconSize = 18,
  });

  final int earned;
  final int total;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: iconSize, color: AppColors.goal),
        const SizedBox(width: 4),
        Text(
          '$earned / $total',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: muted,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
