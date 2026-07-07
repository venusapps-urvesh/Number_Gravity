import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGCard extends StatelessWidget {
  const NGCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.borderColor,
    this.borderWidth = 0,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: brightness == Brightness.dark
          ? [
              AppColors.darkSurface,
              AppColors.neutral800,
            ]
          : [
              Colors.white,
              AppColors.neutral100,
            ],
    );

    final card = Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? AppColors.surfaceBorder(brightness),
                width: borderWidth,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: brightness == Brightness.dark ? 0.25 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: onTap == null
          ? card
          : InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: card,
            ),
    );
  }
}
