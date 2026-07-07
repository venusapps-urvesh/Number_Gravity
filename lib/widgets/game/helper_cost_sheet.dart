import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../common/ng_button.dart';

Future<bool?> showHelperCostSheet(
  BuildContext context, {
  required String title,
  required String body,
  required int cost,
  required int balance,
}) {
  final l10n = AppLocalizations.of(context);
  final canAfford = balance >= cost;

  return showDialog<bool>(
    context: context,
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
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(dialogContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: muted),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.helperCostLabel(cost, balance),
                  style: Theme.of(dialogContext).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.md),
                if (canAfford)
                  NGButton(
                    label: l10n.confirm,
                    variant: NGButtonVariant.accent,
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                  )
                else ...[
                  NGButton(
                    label: l10n.shop,
                    icon: Icons.storefront_outlined,
                    variant: NGButtonVariant.accent,
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                      context.push(AppRoutes.shop);
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  NGButton(
                    label: l10n.cancel,
                    variant: NGButtonVariant.secondary,
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<int?> showHintTierSheet(BuildContext context) {
  final l10n = AppLocalizations.of(context);

  return showModalBottomSheet<int>(
    context: context,
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.hint,
                style: Theme.of(sheetContext).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                leading: const Icon(Icons.touch_app_outlined),
                title: Text(l10n.hintTier1Title),
                subtitle: Text(l10n.hintTier1Cost),
                onTap: () => Navigator.pop(sheetContext, 1),
              ),
              ListTile(
                leading: const Icon(Icons.navigation_outlined),
                title: Text(l10n.hintTier2Title),
                subtitle: Text(l10n.hintTier2Cost),
                onTap: () => Navigator.pop(sheetContext, 2),
              ),
              ListTile(
                leading: const Icon(Icons.lightbulb_rounded),
                title: Text(l10n.hintTier3Title),
                subtitle: Text(l10n.hintTier3Cost),
                onTap: () => Navigator.pop(sheetContext, 3),
              ),
            ],
          ),
        ),
      );
    },
  );
}
