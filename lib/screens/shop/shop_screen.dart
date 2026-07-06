import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';

class _Pack {
  const _Pack({
    required this.icon,
    required this.name,
    required this.coins,
    required this.price,
    this.bonusPercent = 0,
    this.bestValue = false,
  });

  final IconData icon;
  final String name;
  final int coins;
  final String price;
  final int bonusPercent;
  final bool bestValue;
}

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(playerProgressProvider).value;

    final packs = <_Pack>[
      _Pack(
        icon: Icons.account_balance_wallet_rounded,
        name: l10n.packPouch,
        coins: 500,
        price: r'$0.99',
      ),
      _Pack(
        icon: Icons.backpack_rounded,
        name: l10n.packBag,
        coins: 1650,
        price: r'$2.99',
        bonusPercent: 10,
      ),
      _Pack(
        icon: Icons.inventory_2_rounded,
        name: l10n.packChest,
        coins: 6000,
        price: r'$9.99',
        bonusPercent: 20,
        bestValue: true,
      ),
      _Pack(
        icon: Icons.account_balance_rounded,
        name: l10n.packVault,
        coins: 16000,
        price: r'$19.99',
        bonusPercent: 30,
      ),
    ];

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.shop, coinAmount: progress?.coins),
          Expanded(
            child: NGResponsiveLayout(
              child: ListView(
                children: [
                  _StarterPack(l10n: l10n),
                  const SizedBox(height: AppSpacing.md),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.86,
                    children: [
                      for (final pack in packs)
                        _PackCard(pack: pack, l10n: l10n),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _RewardedAdCard(l10n: l10n),
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: Text(
                      l10n.adsOptIn,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onSurfaceMuted(
                              Theme.of(context).brightness,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _notImplemented(BuildContext context, String label) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(label)));
}

class _StarterPack extends StatelessWidget {
  const _StarterPack({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return NGCard(
      onTap: () => _notImplemented(context, l10n.starterPack),
      padding: const EdgeInsets.all(AppSpacing.md),
      borderColor: AppColors.goal,
      borderWidth: 2,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.goal.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: AppColors.goal),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.starterPack,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  l10n.starterPackDesc,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceMuted(
                            Theme.of(context).brightness),
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.goal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              r'$2.99',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  const _PackCard({required this.pack, required this.l10n});

  final _Pack pack;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGCard(
      onTap: () => _notImplemented(context, pack.name),
      padding: const EdgeInsets.all(AppSpacing.md),
      borderColor: pack.bestValue ? AppColors.goal : null,
      borderWidth: pack.bestValue ? 2 : 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (pack.bestValue)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.goal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.bestValue,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral900,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            )
          else
            const SizedBox(height: 18),
          Icon(pack.icon, size: 34, color: AppColors.coinGold),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pack.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  if (pack.bonusPercent > 0) ...[
                    const SizedBox(width: 4),
                    Text(
                      l10n.bonusPercent(pack.bonusPercent),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.leaderboardAccent,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ],
              ),
              Text(
                l10n.coinCount(pack.coins),
                style:
                    Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _notImplemented(context, pack.name),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.positive,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text(pack.price),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardedAdCard extends StatelessWidget {
  const _RewardedAdCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return NGCard(
      onTap: () => _notImplemented(context, l10n.watchAnAd),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          const Icon(Icons.play_circle_fill_rounded,
              color: AppColors.dailyAccent, size: 30),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.watchAnAd,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.monetization_on_rounded,
                  size: 18, color: AppColors.coinGold),
              const SizedBox(width: 4),
              Text(
                l10n.adRewardAmount(25),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.coinGold,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
