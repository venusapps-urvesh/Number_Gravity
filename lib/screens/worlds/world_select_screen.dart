import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../levels/world_config.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../storage/adapters/player_progress.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/world/world_card.dart';

class WorldSelectScreen extends ConsumerWidget {
  const WorldSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progressAsync = ref.watch(playerProgressProvider);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: l10n.selectWorld,
            coinAmount: progressAsync.value?.coins,
          ),
          Expanded(
            child: progressAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (progress) => _WorldList(progress: progress),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorldList extends StatelessWidget {
  const _WorldList({required this.progress});

  final PlayerProgress progress;

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveBreakpoints.isTablet(context);
    final currentWorldId = _currentWorldId(progress);

    if (isTablet) {
      return NGResponsiveLayout(
        maxWidth: ResponsiveBreakpoints.contentMaxWidthTablet + 120,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.4,
          ),
          itemCount: worldConfigs.length,
          itemBuilder: (context, index) => _buildCard(
            context,
            worldConfigs[index],
            progress,
            currentWorldId,
          ),
        ),
      );
    }

    return NGResponsiveLayout(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: worldConfigs.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) => _buildCard(
          context,
          worldConfigs[index],
          progress,
          currentWorldId,
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    WorldConfig world,
    PlayerProgress progress,
    int currentWorldId,
  ) {
    final isUnlocked = progress.unlockedWorlds.contains(world.id);
    final levelIds = List.generate(
      world.endLevel - world.startLevel + 1,
      (i) => world.startLevel + i,
    );
    final completed = levelIds
        .where((id) => progress.levelProgress[id]?.isCompleted ?? false)
        .length;
    final earnedStars = levelIds
        .map((id) => progress.levelProgress[id]?.stars ?? 0)
        .fold<int>(0, (sum, stars) => sum + stars);
    final totalStars = levelIds.length * 3;

    return WorldCard(
      world: world,
      completedLevels: completed,
      totalLevels: levelIds.length,
      earnedStars: earnedStars,
      totalStars: totalStars,
      isUnlocked: isUnlocked,
      isCurrent: world.id == currentWorldId,
      onTap: () => context.go('${AppRoutes.levels}/${world.id}'),
    );
  }

  int _currentWorldId(PlayerProgress progress) {
    for (final world in worldConfigs.reversed) {
      if (progress.unlockedWorlds.contains(world.id)) {
        final hasIncomplete = List.generate(
          world.endLevel - world.startLevel + 1,
          (i) => world.startLevel + i,
        ).any((id) => !(progress.levelProgress[id]?.isCompleted ?? false));
        if (hasIncomplete) {
          return world.id;
        }
      }
    }
    return progress.unlockedWorlds.last;
  }
}
