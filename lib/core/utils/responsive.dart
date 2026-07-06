import 'package:flutter/material.dart';

/// Layout breakpoints — iPad 13" landscape is ~1024 logical points wide.
abstract final class ResponsiveBreakpoints {
  static const double tablet = 1024;
  static const double contentMaxWidthPhone = 480;
  static const double contentMaxWidthTablet = 720;
  static const double gameplayMaxWidthTablet = 960;

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tablet;
  }

  static double contentMaxWidth(BuildContext context) {
    return isTablet(context) ? contentMaxWidthTablet : contentMaxWidthPhone;
  }

  static int gridCrossAxisCount(
    BuildContext context, {
    int phone = 5,
    int tablet = 8,
  }) {
    return isTablet(context) ? tablet : phone;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tablet) {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 24);
    }
    return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
  }
}
