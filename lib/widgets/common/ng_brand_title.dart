import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGBrandTitle extends StatelessWidget {
  const NGBrandTitle({
    super.key,
    this.fontSize = 32,
    this.alignment = TextAlign.center,
  });

  final double fontSize;
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final numberColor = isDark ? AppColors.neutral100 : AppColors.neutral900;

    return RichText(
      textAlign: alignment,
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
        children: [
          TextSpan(
            text: 'Number ',
            style: TextStyle(color: numberColor),
          ),
          TextSpan(
            text: 'Gravity',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
