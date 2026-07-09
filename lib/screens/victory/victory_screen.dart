import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router/navigation.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/game_constants.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/game_session_provider.dart';
import '../../providers/providers.dart';
import '../../widgets/common/language_picker_sheet.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/common/ng_star_rating.dart';

class VictoryScreen extends ConsumerStatefulWidget {
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
  ConsumerState<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends ConsumerState<VictoryScreen> {
  bool _doubled = false;

  Future<void> _shareWithReward() async {
    await AppShare.shareSolution(
      context,
      solutionCode: widget.solutionCode,
      levelId: widget.levelId,
    );
    final reward = await ref.read(engagementServiceProvider).grantShareReward();
    if (!mounted || reward == null) {
      return;
    }
    ref.invalidate(playerProgressProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).adRewardGranted(reward))),
    );
  }

  Future<void> _doubleCoins() async {
    if (_doubled || widget.coinsEarned <= 0) {
      return;
    }
    final ad = ref.read(rewardedAdServiceProvider);
    if (!ad.canShowToday) {
      return;
    }
    final shown = await ad.showRewardedAd();
    if (!shown || !mounted) {
      return;
    }
    await ref.read(economyServiceProvider).earn(
          amount: widget.coinsEarned,
          countsTowardLeaderboard: false,
        );
    setState(() => _doubled = true);
    ref.invalidate(playerProgressProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isTablet = ResponsiveBreakpoints.isTablet(context);
    final totalCoins = widget.coinBalance + widget.coinsEarned + (_doubled ? widget.coinsEarned : 0);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: '',
            showBack: false,
            coinAmount: totalCoins,
          ),
          Expanded(
            child: NGResponsiveLayout(
              maxWidth: isTablet
                  ? 520
                  : ResponsiveBreakpoints.contentMaxWidthPhone,
              child: Column(
                children: [
                  Text(
                    l10n.levelComplete,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  NGStarRating(stars: widget.stars, size: isTablet ? 56 : 48),
                  const SizedBox(height: AppSpacing.lg),
                  NGCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatColumn(
                            icon: Icons.history_rounded,
                            label: l10n.moves,
                            value: '${widget.moves}',
                            subtitle: l10n.optimalLabel(widget.optimalMoves),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 72,
                          color: AppColors.surfaceBorder(
                            Theme.of(context).brightness,
                          ),
                        ),
                        Expanded(
                          child: _StatColumn(
                            icon: Icons.monetization_on_rounded,
                            iconColor: AppColors.coinGold,
                            label: l10n.coinsEarned,
                            value:
                                '+${widget.coinsEarned + (_doubled ? widget.coinsEarned : 0)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  NGCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
                                l10n.shareResultReward(coinsShareResult),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                widget.solutionCode,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
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
                          onPressed: _shareWithReward,
                          icon: const Icon(Icons.ios_share_rounded),
                        ),
                        IconButton(
                          tooltip: l10n.copy,
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: widget.solutionCode),
                            );
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
                    onPressed: () => ngGoToPlay(context, widget.levelId + 1),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: NGButton(
                          label: l10n.replay,
                          icon: Icons.refresh_rounded,
                          variant: NGButtonVariant.secondary,
                          onPressed: () => ngGoToPlay(context, widget.levelId),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: NGButton(
                          label: l10n.home,
                          icon: Icons.home_rounded,
                          variant: NGButtonVariant.secondary,
                          onPressed: () => ngGoHome(context),
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
                    onPressed: _doubled || widget.coinsEarned <= 0
                        ? null
                        : _doubleCoins,
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
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: muted),
          ),
      ],
    );
  }
}
