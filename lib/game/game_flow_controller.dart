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

  Future<int> persistLevelWin({
    required LevelModel level,
    required int movesUsed,
    required List<MoveRecord> moveRecords,
    int hintsUsedThisLevel = 0,
  }) async {
    final stars = starsForMoves(
      movesUsed: movesUsed,
      minimumMoves: level.minimumMoves,
    );

    final progressBefore =
        await ref.read(progressRepositoryProvider).getProgress();
    final isFirstClear =
        !(progressBefore.levelProgress[level.id]?.isCompleted ?? false);

    var coinsEarned = 0;
    if (isFirstClear) {
      coinsEarned += switch (stars) {
        3 => coinsPerStar3,
        2 => coinsPerStar2,
        _ => coinsPerStar1,
      };
      if (level.world > 0) {
        coinsEarned += firstClearBonusForWorld(level.world);
      }
      if (hintsUsedThisLevel == 0) {
        coinsEarned += coinsNoHintBonus;
      }
    } else if (level.world > 0) {
      coinsEarned += coinsReplayClear;
    }

    if (level.world == 0 && isFirstClear) {
      coinsEarned += coinsDailyPuzzleClear;
    }

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
      final leaderboardEligible = isFirstClear || level.world == 0;
      progress.coins += coinsEarned;
      if (leaderboardEligible) {
        progress.gameplayEarnedCoins += coinsEarned;
      }
    }
    if (level.world == 0 && isFirstClear) {
      progress.lastDailyPuzzleDate = _todayKey(DateTime.now());
    }
    if (coinsEarned > 0 || (level.world == 0 && isFirstClear)) {
      await ref.read(progressRepositoryProvider).saveProgress(progress);
    }
    ref.invalidate(playerProgressProvider);

    final solutionCode =
        ref.read(replayServiceProvider).encodeMoves(moveRecords);
    // Stored for optional victory navigation.
    _lastWinPayload = _WinPayload(
      stars: stars,
      movesUsed: movesUsed,
      coinsEarned: coinsEarned,
      balance: progress.coins,
      solutionCode: solutionCode,
    );

    return stars;
  }

  _WinPayload? _lastWinPayload;

  void navigateToVictory(BuildContext context, LevelModel level) {
    final payload = _lastWinPayload;
    if (payload == null || !context.mounted) {
      return;
    }
    context.go(
      '${AppRoutes.victory}/${level.id}'
      '?stars=${payload.stars}'
      '&moves=${payload.movesUsed}'
      '&optimal=${level.minimumMoves}'
      '&coins=${payload.coinsEarned}'
      '&balance=${payload.balance}'
      '&solution=${Uri.encodeComponent(payload.solutionCode)}',
    );
  }

  Future<void> handleLevelWon({
    required BuildContext context,
    required LevelModel level,
    required int movesUsed,
    required List<MoveRecord> moveRecords,
    int hintsUsedThisLevel = 0,
  }) async {
    await persistLevelWin(
      level: level,
      movesUsed: movesUsed,
      moveRecords: moveRecords,
      hintsUsedThisLevel: hintsUsedThisLevel,
    );
    if (!context.mounted) {
      return;
    }
    navigateToVictory(context, level);
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

  Future<int> claimDailyLoginRewardIfNeeded() async {
    final today = _todayKey(DateTime.now());
    final progress = await ref.read(progressRepositoryProvider).getProgress();
    if (progress.lastDailyLoginDate == today) {
      return 0;
    }

    final dayIndex = progress.dailyStreak.clamp(0, dailyLoginRewards.length - 1);
    final reward = dailyLoginRewards[dayIndex];
    progress.coins += reward;
    progress.gameplayEarnedCoins += reward;
    progress.lastDailyLoginDate = today;
    if (progress.dailyStreak < dailyLoginRewards.length) {
      progress.dailyStreak += 1;
    }
    await ref.read(progressRepositoryProvider).saveProgress(progress);
    ref.invalidate(playerProgressProvider);
    return reward;
  }

  static String _todayKey(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }
}

class _WinPayload {
  const _WinPayload({
    required this.stars,
    required this.movesUsed,
    required this.coinsEarned,
    required this.balance,
    required this.solutionCode,
  });

  final int stars;
  final int movesUsed;
  final int coinsEarned;
  final int balance;
  final String solutionCode;
}
