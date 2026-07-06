import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.darkPrimary,
            onPrimary: AppColors.neutral900,
            secondary: AppColors.goal,
            onSecondary: AppColors.neutral900,
            surface: AppColors.darkSurface,
            onSurface: AppColors.neutral100,
            error: AppColors.negative,
          )
        : const ColorScheme.light(
            primary: AppColors.lightPrimary,
            onPrimary: Colors.white,
            secondary: AppColors.goal,
            onSecondary: AppColors.neutral900,
            surface: AppColors.lightSurface,
            onSurface: AppColors.neutral900,
            error: AppColors.negative,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      textTheme: AppTypography.textTheme(brightness),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: isDark ? AppColors.neutral100 : AppColors.neutral900,
      ),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, AppSpacing.minTapTarget),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppSpacing.minTapTarget),
          side: BorderSide(color: AppColors.surfaceBorder(brightness)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, AppSpacing.minTapTarget),
          foregroundColor: scheme.primary,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(AppSpacing.minTapTarget, AppSpacing.minTapTarget),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          minimumSize: const WidgetStatePropertyAll(
            Size(0, AppSpacing.minTapTarget),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return isDark ? AppColors.neutral500 : AppColors.neutral300;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary.withValues(alpha: 0.35);
          }
          return isDark ? AppColors.neutral700 : AppColors.neutral200;
        }),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.surfaceBorder(brightness),
        space: 1,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.neutral800 : AppColors.neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.surfaceBorder(brightness)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.surfaceBorder(brightness)),
        ),
      ),
    );
  }
}
