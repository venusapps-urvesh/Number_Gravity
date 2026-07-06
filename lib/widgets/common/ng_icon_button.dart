import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGIconButton extends StatelessWidget {
  const NGIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.minTapTarget,
      height: AppSpacing.minTapTarget,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
