import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router/navigation.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../levels/world_config.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/common/ng_star_rating.dart';

class LevelSelectScreen extends ConsumerWidget {
  const LevelSelectScreen({required this.worldId, super.key});

  final int worldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final levelsFuture = ref.watch(_worldLevelsProvider(worldId));
    final progress = ref.watch(playerProgressProvider).value;

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: '${l10n.levels} — World $worldId',
            coinAmount: progress?.coins,
          ),
          Expanded(
            child: levelsFuture.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (levels) => NGResponsiveLayout(
                maxWidth: ResponsiveBreakpoints.isTablet(context)
                    ? ResponsiveBreakpoints.contentMaxWidthTablet + 200
                    : ResponsiveBreakpoints.contentMaxWidthPhone,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveBreakpoints.gridCrossAxisCount(
                      context,
                      phone: 5,
                      tablet: 8,
                    ),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    final stars = progress?.levelProgress[level.id]?.stars ?? 0;
                    final completed =
                        progress?.levelProgress[level.id]?.isCompleted ?? false;
                    final unlocked = progress == null ||
                        isLevelUnlocked(progress, level.id);

                    return Opacity(
                      opacity: unlocked ? 1 : 0.5,
                      child: NGCard(
                        padding: const EdgeInsets.all(8),
                        onTap: unlocked
                            ? () => ngPushToPlay(context, level.id)
                            : null,
                        borderColor: completed
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.4)
                            : null,
                        borderWidth: completed ? 1 : 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${level.id}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                if (stars > 0) ...[
                                  const SizedBox(height: 4),
                                  NGStarRating(
                                    stars: stars,
                                    size: 12,
                                    spacing: 0,
                                  ),
                                ],
                              ],
                            ),
                            if (!unlocked)
                              Icon(
                                Icons.lock_rounded,
                                size: 16,
                                color: AppColors.onSurfaceMuted(
                                  Theme.of(context).brightness,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _worldLevelsProvider = FutureProvider.family((ref, int worldId) {
  return ref.watch(levelRepositoryProvider).loadWorld(worldId);
});
