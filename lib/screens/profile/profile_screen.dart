import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../levels/world_config.dart';
import '../../providers/providers.dart';
import '../../storage/adapters/player_progress.dart';
import '../../storage/adapters/statistics_data.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progressAsync = ref.watch(playerProgressProvider);
    final statsAsync = ref.watch(_statsProvider);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.profile),
          Expanded(
            child: progressAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (progress) => NGResponsiveLayout(
                child: ListView(
                  children: [
                    _Header(progress: progress),
                    const SizedBox(height: AppSpacing.lg),
                    _StatTiles(progress: progress),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.worldProgress,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _WorldProgressList(progress: progress),
                    const SizedBox(height: AppSpacing.lg),
                    _PlayStats(stats: statsAsync.value),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _statsProvider = FutureProvider<StatisticsData>((ref) async {
  await ref.watch(storageInitProvider.future);
  return ref.read(statisticsRepositoryProvider).getStatistics();
});

class _Header extends StatelessWidget {
  const _Header({required this.progress});

  final PlayerProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.positive, AppColors.dailyAccent],
            ),
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 34),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.you,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.local_fire_department_rounded,
                      size: 16, color: AppColors.coinGold),
                  const SizedBox(width: 4),
                  Text(
                    l10n.dayStreak(progress.dailyStreak),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: muted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatTiles extends StatelessWidget {
  const _StatTiles({required this.progress});

  final PlayerProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final completed =
        progress.levelProgress.values.where((p) => p.isCompleted).length;
    final stars = progress.levelProgress.values
        .fold<int>(0, (sum, p) => sum + p.stars);

    return Row(
      children: [
        _StatTile(
          value: '$completed',
          label: l10n.statLevels,
          color: AppColors.positive,
          icon: Icons.grid_view_rounded,
        ),
        const SizedBox(width: AppSpacing.sm),
        _StatTile(
          value: '$stars',
          label: l10n.statStars,
          color: AppColors.goal,
          icon: Icons.star_rounded,
        ),
        const SizedBox(width: AppSpacing.sm),
        _StatTile(
          value: '${progress.gameplayEarnedCoins}',
          label: l10n.statEarnedCoins,
          color: AppColors.coinGold,
          icon: Icons.monetization_on_rounded,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String value;
  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Expanded(
      child: NGCard(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorldProgressList extends StatelessWidget {
  const _WorldProgressList({required this.progress});

  final PlayerProgress progress;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGCard(
      child: Column(
        children: [
          for (var i = 0; i < worldConfigs.length; i++) ...[
            if (i > 0) const Divider(height: AppSpacing.lg),
            _worldRow(context, worldConfigs[i], muted),
          ],
        ],
      ),
    );
  }

  Widget _worldRow(BuildContext context, WorldConfig world, Color muted) {
    final levelIds = List.generate(
      world.endLevel - world.startLevel + 1,
      (i) => world.startLevel + i,
    );
    final completed = levelIds
        .where((id) => progress.levelProgress[id]?.isCompleted ?? false)
        .length;
    final total = levelIds.length;
    final ratio = total == 0 ? 0.0 : completed / total;
    final isUnlocked = progress.unlockedWorlds.contains(world.id);

    return Row(
      children: [
        SizedBox(
          width: 28,
          child: Text(
            'W${world.id}',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: isUnlocked ? ratio : 0,
              minHeight: 8,
              backgroundColor:
                  AppColors.surfaceBorder(Theme.of(context).brightness),
              valueColor: const AlwaysStoppedAnimation(AppColors.positive),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 46,
          child: Text(
            isUnlocked ? '$completed/$total' : '🔒',
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
          ),
        ),
      ],
    );
  }
}

class _PlayStats extends StatelessWidget {
  const _PlayStats({required this.stats});

  final StatisticsData? stats;

  @override
  Widget build(BuildContext context) {
    if (stats == null) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: muted),
                ),
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );

    return NGCard(
      child: Column(
        children: [
          row(l10n.totalMovesLabel, '${stats!.totalMoves}'),
          row(l10n.hintsUsedLabel, '${stats!.hintsUsed}'),
          row(l10n.undo, '${stats!.undosUsed}'),
        ],
      ),
    );
  }
}
