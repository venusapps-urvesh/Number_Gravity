import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../common/ng_button.dart';

Future<void> showGamePauseSheet(
  BuildContext context, {
  required VoidCallback onResume,
  required VoidCallback onRestart,
  required VoidCallback onLevels,
}) {
  final l10n = AppLocalizations.of(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (dialogContext) {
      final brightness = Theme.of(dialogContext).brightness;
      final surface = brightness == Brightness.dark
          ? AppColors.darkSurface
          : AppColors.lightSurface;
      final border = AppColors.surfaceBorder(brightness);

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: brightness == Brightness.dark ? 0.35 : 0.18,
                  ),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.pause,
                  style: Theme.of(dialogContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                NGButton(
                  label: l10n.resume,
                  icon: Icons.play_arrow_rounded,
                  variant: NGButtonVariant.accent,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onResume();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                NGButton(
                  label: l10n.restart,
                  icon: Icons.refresh_rounded,
                  variant: NGButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onRestart();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                NGButton(
                  label: l10n.levels,
                  icon: Icons.grid_view_rounded,
                  variant: NGButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onLevels();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showGameStuckSheet(
  BuildContext context, {
  required VoidCallback onUndo,
  required VoidCallback onRestart,
  required VoidCallback onExit,
}) {
  final l10n = AppLocalizations.of(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (dialogContext) {
      final brightness = Theme.of(dialogContext).brightness;
      final surface = brightness == Brightness.dark
          ? AppColors.darkSurface
          : AppColors.lightSurface;
      final border = AppColors.surfaceBorder(brightness);
      final muted = AppColors.onSurfaceMuted(brightness);

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: brightness == Brightness.dark ? 0.35 : 0.18,
                  ),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.stuckTitle,
                  style: Theme.of(dialogContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.stuckBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: muted),
                ),
                const SizedBox(height: AppSpacing.md),
                NGButton(
                  label: l10n.undo,
                  icon: Icons.undo_rounded,
                  variant: NGButtonVariant.accent,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onUndo();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                NGButton(
                  label: l10n.restart,
                  icon: Icons.refresh_rounded,
                  variant: NGButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onRestart();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                NGButton(
                  label: l10n.levels,
                  icon: Icons.grid_view_rounded,
                  variant: NGButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onExit();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
