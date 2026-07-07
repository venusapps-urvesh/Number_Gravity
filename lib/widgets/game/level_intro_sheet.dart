import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../levels/world_config.dart';
import '../../l10n/app_localizations.dart';
import '../common/ng_button.dart';

Future<void> showLevelIntroSheet(
  BuildContext context, {
  required WorldConfig world,
}) {
  final l10n = AppLocalizations.of(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
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
            width: 320,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  world.name,
                  style: Theme.of(dialogContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.worldMechanic(world.mechanic),
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: muted),
                ),
                const SizedBox(height: AppSpacing.md),
                NGButton(
                  label: l10n.letsPlay,
                  icon: Icons.play_arrow_rounded,
                  variant: NGButtonVariant.accent,
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
