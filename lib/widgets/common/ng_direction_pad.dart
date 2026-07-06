import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/move.dart';

class NGDirectionPad extends StatelessWidget {
  const NGDirectionPad({
    required this.onDirection,
    super.key,
    this.label,
  });

  final ValueChanged<Direction> onDirection;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final surface = brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final border = AppColors.surfaceBorder(brightness);
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: brightness == Brightness.dark ? 0.25 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceMuted(brightness),
                  ),
            ),
            const SizedBox(height: 8),
          ],
          _DirectionButton(
            icon: Icons.keyboard_arrow_up_rounded,
            color: primary,
            onPressed: () => onDirection(Direction.up),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DirectionButton(
                icon: Icons.keyboard_arrow_left_rounded,
                color: primary,
                onPressed: () => onDirection(Direction.left),
              ),
              const SizedBox(width: 56),
              _DirectionButton(
                icon: Icons.keyboard_arrow_right_rounded,
                color: primary,
                onPressed: () => onDirection(Direction.right),
              ),
            ],
          ),
          _DirectionButton(
            icon: Icons.keyboard_arrow_down_rounded,
            color: primary,
            onPressed: () => onDirection(Direction.down),
          ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  const _DirectionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final fill = brightness == Brightness.dark
        ? AppColors.neutral800
        : AppColors.neutral100;

    return Material(
      color: fill,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: SizedBox(
          width: AppSpacing.minTapTarget + 8,
          height: AppSpacing.minTapTarget + 8,
          child: Icon(icon, color: color, size: 32),
        ),
      ),
    );
  }
}
