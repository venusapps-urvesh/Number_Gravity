import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/game/tile_badge.dart';
import '../../models/tile_type.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;

    return NGScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.homeTitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.homeSubtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.neutral500,
                  ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TileBadge(
                  value: 3,
                  type: TileType.number,
                  colorBlindMode: colorBlind,
                ),
                const SizedBox(width: AppSpacing.md),
                TileBadge(
                  value: -2,
                  type: TileType.number,
                  colorBlindMode: colorBlind,
                ),
                const SizedBox(width: AppSpacing.md),
                TileBadge(
                  value: 0,
                  type: TileType.goal,
                  colorBlindMode: colorBlind,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            NGCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.themeMode,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(l10n.themeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(l10n.themeDark),
                      ),
                    ],
                    selected: {themeMode},
                    onSelectionChanged: (selection) {
                      ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(selection.first);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.colorBlindMode),
                    value: colorBlind,
                    onChanged: (value) {
                      ref
                          .read(colorBlindModeProvider.notifier)
                          .setEnabled(value);
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            NGButton(
              label: l10n.playLevel,
              icon: Icons.play_arrow_rounded,
              onPressed: () => context.go('${AppRoutes.play}/1'),
            ),
            const SizedBox(height: AppSpacing.sm),
            NGButton(
              label: l10n.worlds,
              variant: NGButtonVariant.secondary,
              onPressed: () => context.go(AppRoutes.worlds),
            ),
            const SizedBox(height: AppSpacing.sm),
            NGButton(
              label: l10n.dailyPuzzle,
              variant: NGButtonVariant.ghost,
              onPressed: () => context.go(AppRoutes.daily),
            ),
            const SizedBox(height: AppSpacing.sm),
            NGButton(
              label: l10n.settings,
              variant: NGButtonVariant.ghost,
              onPressed: () => context.go(AppRoutes.settings),
            ),
          ],
        ),
      ),
    );
  }
}
