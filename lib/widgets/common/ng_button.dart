import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

enum NGButtonVariant { primary, secondary, ghost, accent }

enum NGButtonAccent { play, daily, leaderboard, goal }

class NGButton extends StatelessWidget {
  const NGButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = NGButtonVariant.primary,
    this.accent = NGButtonAccent.play,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final NGButtonVariant variant;
  final NGButtonAccent accent;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(label),
            ],
          );

    final button = switch (variant) {
      NGButtonVariant.primary => _primaryButton(context, child),
      NGButtonVariant.accent => _accentButton(context, child),
      NGButtonVariant.secondary => OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      NGButtonVariant.ghost => TextButton(
          onPressed: onPressed,
          child: child,
        ),
    };

    if (!expand) {
      return button;
    }

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.minTapTarget + 8,
      child: button,
    );
  }

  Widget _primaryButton(BuildContext context, Widget child) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.35),
      ),
      child: child,
    );
  }

  Widget _accentButton(BuildContext context, Widget child) {
    final color = switch (accent) {
      NGButtonAccent.play => AppColors.positive,
      NGButtonAccent.daily => AppColors.dailyAccent,
      NGButtonAccent.leaderboard => AppColors.leaderboardAccent,
      NGButtonAccent.goal => AppColors.goal,
    };
    final onColor = accent == NGButtonAccent.goal
        ? AppColors.neutral900
        : Colors.white;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: onColor,
        elevation: 2,
        shadowColor: color.withValues(alpha: 0.35),
      ),
      child: child,
    );
  }
}
