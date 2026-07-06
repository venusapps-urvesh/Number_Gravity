import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/language_picker_sheet.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/common/ng_star_rating.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({
    required this.stars,
    required this.moves,
    required this.optimalMoves,
    required this.coinsEarned,
    required this.solutionCode,
    required this.levelId,
    super.key,
    this.coinBalance = 0,
  });

  final int stars;
  final int moves;
  final int optimalMoves;
  final int coinsEarned;
  final String solutionCode;
  final int levelId;
  final int coinBalance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isTablet = ResponsiveBreakpoints.isTablet(context);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: '',
            showBack: false,
            coinAmount: coinBalance + coinsEarned,
          ),
          Expanded(
            child: NGResponsiveLayout(
              maxWidth: isTablet ? 520 : ResponsiveBreakpoints.contentMaxWidthPhone,
              child: Column(
                children: [
                  Text(
                    l10n.levelComplete,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  NGStarRating(stars: stars, size: isTablet ? 56 : 48),
                  const SizedBox(height: AppSpacing.lg),
                  NGCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatColumn(
                            icon: Icons.history_rounded,
                            label: l10n.moves,
                            value: '$moves',
                            subtitle: l10n.optimalLabel(optimalMoves),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 72,
                          color: AppColors.surfaceBorder(Theme.of(context).brightness),
                        ),
                        Expanded(
                          child: _StatColumn(
                            icon: Icons.monetization_on_rounded,
                            iconColor: AppColors.coinGold,
                            label: l10n.coinsEarned,
                            value: '+$coinsEarned',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  NGCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.shareSolution,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                solutionCode,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.onSurfaceMuted(
                                        Theme.of(context).brightness,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.shareApp,
                          onPressed: () => AppShare.shareSolution(
                            context,
                            solutionCode: solutionCode,
                            levelId: levelId,
                          ),
                          icon: const Icon(Icons.ios_share_rounded),
                        ),
                        IconButton(
                          tooltip: l10n.copy,
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: solutionCode));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.copied)),
                              );
                            }
                          },
                          icon: const Icon(Icons.copy_rounded),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  NGButton(
                    label: l10n.nextLevel,
                    icon: Icons.chevron_right_rounded,
                    onPressed: () => context.go('${AppRoutes.play}/${levelId + 1}'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: NGButton(
                          label: l10n.replay,
                          icon: Icons.refresh_rounded,
                          variant: NGButtonVariant.secondary,
                          onPressed: () => context.go('${AppRoutes.play}/$levelId'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: NGButton(
                          label: l10n.home,
                          icon: Icons.home_rounded,
                          variant: NGButtonVariant.secondary,
                          onPressed: () => context.go(AppRoutes.home),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  NGButton(
                    label: l10n.doubleCoins,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.goal,
                    icon: Icons.ondemand_video_rounded,
                    onPressed: null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Column(
      children: [
        Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted)),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        if (subtitle != null)
          Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted)),
      ],
    );
  }
}
