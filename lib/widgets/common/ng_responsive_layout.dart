import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';

/// Centers content and constrains width for phone and tablet layouts.
class NGResponsiveLayout extends StatelessWidget {
  const NGResponsiveLayout({
    required this.child,
    super.key,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final resolvedMaxWidth = maxWidth ?? ResponsiveBreakpoints.contentMaxWidth(context);
    final resolvedPadding = padding ?? ResponsiveBreakpoints.screenPadding(context);

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: resolvedMaxWidth),
        child: Padding(
          padding: resolvedPadding,
          child: child,
        ),
      ),
    );
  }
}
