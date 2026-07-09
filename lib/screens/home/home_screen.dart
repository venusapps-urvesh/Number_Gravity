import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/language_picker_sheet.dart';
import '../../widgets/common/ng_bottom_nav.dart';
import '../../widgets/common/ng_brand_title.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_coin_badge.dart';
import '../../widgets/common/ng_icon_button.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/game/tile_badge.dart';
import '../../models/tile_type.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final progress = ref.watch(playerProgressProvider).value;
    final isTablet = ResponsiveBreakpoints.isTablet(context);
    final tileSize = isTablet ? 80.0 : 64.0;

    return NGScaffold(
      body: Column(
        children: [
          Expanded(
            child: NGResponsiveLayout(
              maxWidth: isTablet
                  ? 560
                  : ResponsiveBreakpoints.contentMaxWidthPhone,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      NGIconButton(
                        icon: Icons.language_rounded,
                        tooltip: l10n.language,
                        variant: NGIconButtonVariant.surface,
                        onPressed: () => showLanguagePicker(context, ref),
                      ),
                      NGIconButton(
                        icon: Icons.share_rounded,
                        tooltip: l10n.shareApp,
                        variant: NGIconButtonVariant.surface,
                        onPressed: () => AppShare.shareApp(context),
                      ),
                      NGIconButton(
                        icon: Icons.help_outline_rounded,
                        tooltip: l10n.howToPlay,
                        variant: NGIconButtonVariant.surface,
                        onPressed: () => context.push(AppRoutes.howToPlay),
                      ),
                      const Spacer(),
                      NGCoinBadge(amount: progress?.coins ?? 0),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const NGBrandTitle(),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.homeSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onSurfaceMuted(
                        Theme.of(context).brightness,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? AppSpacing.xl : AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileBadge(
                        value: 3,
                        type: TileType.number,
                        colorBlindMode: colorBlind,
                        size: tileSize,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      TileBadge(
                        value: -2,
                        type: TileType.number,
                        colorBlindMode: colorBlind,
                        size: tileSize,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      TileBadge(
                        value: 0,
                        type: TileType.goal,
                        colorBlindMode: colorBlind,
                        size: tileSize,
                      ),
                    ],
                  ),
                  const Spacer(),
                  NGButton(
                    label: l10n.playCampaign,
                    icon: Icons.play_arrow_rounded,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.play,
                    onPressed: () => context.push(AppRoutes.worlds),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  NGButton(
                    label: l10n.dailyPuzzle,
                    icon: Icons.calendar_today_rounded,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.daily,
                    onPressed: () => context.push(AppRoutes.daily),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  NGButton(
                    label: l10n.leaderboard,
                    icon: Icons.leaderboard_rounded,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.leaderboard,
                    onPressed: () => context.push(AppRoutes.leaderboard),
                  ),
                  SizedBox(height: isTablet ? AppSpacing.xl : AppSpacing.lg),
                ],
              ),
            ),
          ),
          NGBottomNavBar(
            currentIndex: -1,
            items: ngPrimaryBottomNavItems(l10n),
          ),
        ],
      ),
    );
  }
}
