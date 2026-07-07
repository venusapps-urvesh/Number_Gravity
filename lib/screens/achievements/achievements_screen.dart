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

class _Achievement {
  const _Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.target,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int progress;
  final int target;

  bool get isComplete => progress >= target;
  double get ratio => target == 0 ? 0 : (progress / target).clamp(0.0, 1.0);
}

final _unlockedProvider = FutureProvider<Set<String>>((ref) async {
  await ref.watch(storageInitProvider.future);
  final records = await ref.read(achievementsRepositoryProvider).getUnlocked();
  return records.map((r) => r.id).toSet();
});

final _achievementDataProvider =
    FutureProvider<({PlayerProgress progress, StatisticsData stats})>((ref) async {
  await ref.watch(storageInitProvider.future);
  final progress = await ref.read(progressRepositoryProvider).getProgress();
  final stats = await ref.read(statisticsRepositoryProvider).getStatistics();
  return (progress: progress, stats: stats);
});

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final achievementData = ref.watch(_achievementDataProvider);
    final unlocked = ref.watch(_unlockedProvider).value ?? const <String>{};

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.achievements),
          Expanded(
            child: achievementData.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (data) {
                final items = _build(l10n, data.progress, data.stats);
                final done = items.where((a) => a.isComplete).length;
                items.sort((a, b) {
                  final aClaimable = a.isComplete && !unlocked.contains(a.id);
                  final bClaimable = b.isComplete && !unlocked.contains(b.id);
                  if (aClaimable != bClaimable) return aClaimable ? -1 : 1;
                  return b.ratio.compareTo(a.ratio);
                });

                return NGResponsiveLayout(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          l10n.achievementsCount(done, items.length),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: AppColors.onSurfaceMuted(
                                    Theme.of(context).brightness),
                              ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.md),
                          itemBuilder: (context, i) => _AchievementCard(
                            achievement: items[i],
                            unlocked: unlocked.contains(items[i].id),
                            onClaim: () => ref
                                .read(achievementsRepositoryProvider)
                                .unlock(items[i].id)
                                .then((_) => ref.invalidate(_unlockedProvider)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<_Achievement> _build(
    AppLocalizations l10n,
    PlayerProgress progress,
    StatisticsData stats,
  ) {
    final world1 = worldConfigs.first;
    final world1Done = List.generate(
      world1.endLevel - world1.startLevel + 1,
      (i) => world1.startLevel + i,
    ).where((id) => progress.levelProgress[id]?.isCompleted ?? false).length;

    final threeStar =
        progress.levelProgress.values.where((p) => p.stars >= 3).length;
    final noHintProgress =
        (stats.levelsCompleted - stats.hintsUsed).clamp(0, 999);

    return [
      _Achievement(
        id: 'first_world',
        title: l10n.achFirstWorldTitle,
        description: l10n.achFirstWorldDesc,
        icon: Icons.emoji_events_rounded,
        color: AppColors.goal,
        progress: world1Done,
        target: 25,
      ),
      _Achievement(
        id: 'perfectionist',
        title: l10n.achPerfectTitle,
        description: l10n.achPerfectDesc,
        icon: Icons.gps_fixed_rounded,
        color: AppColors.positive,
        progress: threeStar,
        target: 10,
      ),
      _Achievement(
        id: 'streak_week',
        title: l10n.achStreakTitle,
        description: l10n.achStreakDesc,
        icon: Icons.local_fire_department_rounded,
        color: AppColors.dailyAccent,
        progress: progress.dailyStreak,
        target: 7,
      ),
      _Achievement(
        id: 'speed_solver',
        title: l10n.achSpeedTitle,
        description: l10n.achSpeedDesc,
        icon: Icons.bolt_rounded,
        color: AppColors.leaderboardAccent,
        progress: threeStar,
        target: 30,
      ),
      _Achievement(
        id: 'no_hint',
        title: l10n.achNoHintTitle,
        description: l10n.achNoHintDesc,
        icon: Icons.psychology_rounded,
        color: AppColors.negative,
        progress: noHintProgress,
        target: 25,
      ),
      _Achievement(
        id: 'daily_devotee',
        title: l10n.achDailyTitle,
        description: l10n.achDailyDesc,
        icon: Icons.calendar_month_rounded,
        color: AppColors.coinGold,
        progress: progress.dailyStreak,
        target: 30,
      ),
    ];
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.achievement,
    required this.unlocked,
    required this.onClaim,
  });

  final _Achievement achievement;
  final bool unlocked;
  final VoidCallback onClaim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);
    final claimable = achievement.isComplete && !unlocked;
    final dim = !achievement.isComplete && !unlocked;

    return Opacity(
      opacity: dim ? 0.65 : 1,
      child: NGCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (unlocked || achievement.isComplete)
                    ? achievement.color.withValues(alpha: 0.18)
                    : AppColors.surfaceBorder(Theme.of(context).brightness),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                (unlocked || achievement.isComplete)
                    ? achievement.icon
                    : Icons.lock_rounded,
                color: (unlocked || achievement.isComplete)
                    ? achievement.color
                    : muted,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    achievement.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: muted),
                  ),
                  if (!achievement.isComplete) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: achievement.ratio,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceBorder(
                            Theme.of(context).brightness),
                        valueColor:
                            AlwaysStoppedAnimation(achievement.color),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${achievement.progress}/${achievement.target}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: muted),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (unlocked)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.leaderboardAccent)
            else if (claimable)
              ElevatedButton(
                onPressed: onClaim,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goal,
                  foregroundColor: AppColors.neutral900,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                ),
                child: Text(l10n.claim),
              ),
          ],
        ),
      ),
    );
  }
}
