import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/common/ng_scaffold.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsFuture = ref.watch(_statsProvider);

    return NGScaffold(
      body: statsFuture.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (stats) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
            Text('Moves: ${stats.totalMoves}'),
            Text('Levels completed: ${stats.levelsCompleted}'),
            Text('Hints used: ${stats.hintsUsed}'),
          ],
        ),
      ),
    );
  }
}

final _statsProvider = FutureProvider((ref) {
  return ref.watch(statisticsRepositoryProvider).getStatistics();
});
