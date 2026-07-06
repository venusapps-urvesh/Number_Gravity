import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

enum NGIconButtonVariant { plain, surface }

class NGIconButton extends StatelessWidget {
  const NGIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.variant = NGIconButtonVariant.plain,
    this.badge,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final NGIconButtonVariant variant;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    Widget child = Icon(icon, size: 22);

    if (badge != null && badge! > 0) {
      child = Badge(
        label: Text('$badge'),
        child: child,
      );
    }

    final button = IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: child,
      style: variant == NGIconButtonVariant.surface
          ? IconButton.styleFrom(
              backgroundColor: brightness == Brightness.dark
                  ? AppColors.neutral800
                  : AppColors.neutral100,
              foregroundColor: Theme.of(context).colorScheme.primary,
              minimumSize: const Size(AppSpacing.minTapTarget, AppSpacing.minTapTarget),
            )
          : null,
    );

    return SizedBox(
      width: AppSpacing.minTapTarget,
      height: AppSpacing.minTapTarget,
      child: button,
    );
  }
}
