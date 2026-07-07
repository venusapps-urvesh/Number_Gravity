import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/game_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../models/level/level_model.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_loading.dart';
import '../../widgets/common/ng_scaffold.dart';

class GameplayScreen extends ConsumerWidget {
  const GameplayScreen({
    this.levelId,
    this.level,
    super.key,
  }) : assert(levelId != null || level != null);

  final int? levelId;
  final LevelModel? level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    if (level != null) {
      return NGScaffold(
        body: NumberGravityGameWidget(level: level!),
      );
    }

    final levelFuture = ref.watch(_levelProvider(levelId!));

    return NGScaffold(
      body: levelFuture.when(
        loading: () => NGLoading(message: l10n.loading),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (loadedLevel) => NumberGravityGameWidget(level: loadedLevel),
      ),
    );
  }
}

final _levelProvider = FutureProvider.family(
  (ref, int levelId) {
    return ref.watch(levelRepositoryProvider).loadLevel(levelId);
  },
);
