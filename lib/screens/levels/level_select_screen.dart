import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_scaffold.dart';

class LevelSelectScreen extends ConsumerWidget {
  const LevelSelectScreen({required this.worldId, super.key});

  final int worldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsFuture = ref.watch(_worldLevelsProvider(worldId));

    return NGScaffold(
      body: levelsFuture.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (levels) => GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: levels.length,
          itemBuilder: (context, index) {
            final level = levels[index];
            return NGCard(
              padding: const EdgeInsets.all(8),
              onTap: () => context.go('${AppRoutes.play}/${level.id}'),
              child: Center(child: Text('${level.id}')),
            );
          },
        ),
      ),
    );
  }
}

final _worldLevelsProvider = FutureProvider.family((ref, int worldId) {
  return ref.watch(levelRepositoryProvider).loadWorld(worldId);
});
