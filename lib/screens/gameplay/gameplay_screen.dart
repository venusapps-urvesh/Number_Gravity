import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../game/game_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_app_bar.dart';
import '../../widgets/common/ng_loading.dart';
import '../../widgets/common/ng_scaffold.dart';

class GameplayScreen extends ConsumerWidget {
  const GameplayScreen({
    required this.levelId,
    super.key,
  });

  final int levelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final levelFuture = ref.watch(_levelProvider(levelId));

    return NGScaffold(
      appBar: NGAppBar(
        title: 'Level $levelId',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: levelFuture.when(
        loading: () => NGLoading(message: l10n.loading),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (level) => NumberGravityGameWidget(level: level),
      ),
    );
  }
}

final _levelProvider = FutureProvider.family(
  (ref, int levelId) {
    return ref.watch(levelRepositoryProvider).loadLevel(levelId);
  },
);
