import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/router/navigation.dart';
import '../app/router/routes.dart';
import '../core/constants/game_constants.dart';
import '../levels/world_config.dart';
import '../models/level/level_model.dart';
import '../models/replay/move_record.dart';
import '../providers/game_session_provider.dart';
import '../providers/providers.dart';
import '../services/economy/coin_service.dart';

class GameFlowController {
  GameFlowController(this.ref);

  final WidgetRef ref;

  Future<void> handleLevelWon({
    required BuildContext context,
    required LevelModel level,
    required int movesUsed,
    required List<MoveRecord> moveRecords,
  }) async {
    final stars = starsForMoves(
      movesUsed: movesUsed,
      minimumMoves: level.minimumMoves,
    );

    final progressBefore =
        await ref.read(progressRepositoryProvider).getProgress();
    final isFirstClear =
        !(progressBefore.levelProgress[level.id]?.isCompleted ?? false);
    final coinsEarned = isFirstClear
        ? switch (stars) {
            3 => coinsPerStar3,
            2 => coinsPerStar2,
            _ => coinsPerStar1,
          }
        : 0;

    await ref.read(progressRepositoryProvider).setLevelStars(
          levelId: level.id,
          stars: stars,
          movesUsed: movesUsed,
        );

    final world = worldForLevel(level.id);
    if (world != null &&
        level.id == world.endLevel &&
        world.id < totalWorlds) {
      await ref.read(progressRepositoryProvider).unlockWorld(world.id + 1);
    }

    await ref.read(statisticsRepositoryProvider).recordLevelComplete();

    final progress = await ref.read(progressRepositoryProvider).getProgress();
    if (coinsEarned > 0) {
      progress.coins += coinsEarned;
      progress.gameplayEarnedCoins += coinsEarned;
    }
    if (level.world == 0) {
      progress.dailyStreak += 1;
    }
    if (coinsEarned > 0 || level.world == 0) {
      await ref.read(progressRepositoryProvider).saveProgress(progress);
    }
    ref.invalidate(playerProgressProvider);

    final solutionCode =
        ref.read(replayServiceProvider).encodeMoves(moveRecords);
    if (!context.mounted) {
      return;
    }

    context.go(
      '${AppRoutes.victory}/${level.id}'
      '?stars=$stars'
      '&moves=$movesUsed'
      '&optimal=${level.minimumMoves}'
      '&coins=$coinsEarned'
      '&balance=${progress.coins - coinsEarned}'
      '&solution=${Uri.encodeComponent(solutionCode)}',
    );
  }

  void exitGameplay(BuildContext context, LevelModel level) {
    if (level.world == 0) {
      context.go(AppRoutes.daily);
      return;
    }
    ngExitPlayToLevels(context, level.world);
  }

  Future<bool> trySpendForHelper({
    required int cost,
    required CoinSink sink,
  }) async {
    if (cost <= 0) {
      return true;
    }
    final economy = ref.read(economyServiceProvider);
    final ok = await economy.trySpend(amount: cost, sink: sink);
    if (ok) {
      ref.invalidate(playerProgressProvider);
    }
    return ok;
  }
}
