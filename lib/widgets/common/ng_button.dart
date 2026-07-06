import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

enum NGButtonVariant { primary, secondary, ghost }

class NGButton extends StatelessWidget {
  const NGButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = NGButtonVariant.primary,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final NGButtonVariant variant;
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
      NGButtonVariant.primary => ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
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
      child: button,
    );
  }
}
