import 'package:flutter/material.dart';

import '../../core/constants/board_constants.dart';

/// Design tokens (Section 11).
class AppColors {
  AppColors._();

  static const Color positive = Color(0xFF2563EB);
  static const Color negative = Color(0xFFDC2626);
  static const Color goal = Color(0xFFFBBF24);

  static const Color neutral100 = Color(0xFFF8FAFC);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  static const Color lightBackground = Color(0xFFF1F5F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);

  static const Color lightPrimary = positive;
  static const Color darkPrimary = Color(0xFF60A5FA);

  static Color tileColorForValue(int value) {
    if (value > 0) {
      return positive;
    }
    if (value < 0) {
      return negative;
    }
    return neutral500;
  }

  static Color signAccentForValue(int value) {
    if (value > 0) {
      return const Color(0xFF1D4ED8);
    }
    if (value < 0) {
      return const Color(0xFFB91C1C);
    }
    return neutral600;
  }
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double minTapTarget = minTapTargetPx;
}
