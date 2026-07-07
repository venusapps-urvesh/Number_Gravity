import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/core/constants/game_constants.dart';
import 'package:number_gravity/services/economy/coin_service.dart';
import 'package:number_gravity/services/economy/economy_service.dart';
import 'package:number_gravity/services/economy/helper_pricing.dart';
import 'package:number_gravity/storage/adapters/player_progress.dart';
import 'package:number_gravity/storage/repositories/progress_repository.dart';

class _MemoryProgressRepository implements ProgressRepository {
  PlayerProgress progress = PlayerProgress(coins: 100);

  @override
  Future<PlayerProgress> getProgress() async => progress;

  @override
  Future<void> saveProgress(PlayerProgress p) async {
    progress = p;
  }

  @override
  Future<int> getLevelStars(int levelId) async => 0;

  @override
  Future<void> setLevelStars({
    required int levelId,
    required int stars,
    int? movesUsed,
  }) async {}

  @override
  Future<bool> isLevelUnlocked(int levelId) async => true;

  @override
  Future<void> unlockWorld(int worldId) async {}
}

void main() {
  group('HelperPricing', () {
    test('first undo is free', () {
      expect(undoCostForLevel(0), 0);
      expect(undoCostForLevel(1), coinCostUndoAfterFree);
    });

    test('hint tiers map to doc costs', () {
      expect(hintCostForTier(1), 20);
      expect(hintCostForTier(2), 40);
      expect(hintCostForTier(3), 80);
    });
  });

  group('EconomyService', () {
    test('spend deducts balance without touching earned total', () async {
      final repo = _MemoryProgressRepository();
      final service = EconomyService(repo);

      final ok = await service.trySpend(
        amount: 10,
        sink: CoinSink.undo,
      );

      expect(ok, isTrue);
      final progress = await repo.getProgress();
      expect(progress.coins, 90);
      expect(progress.gameplayEarnedCoins, 0);
    });

    test('cannot spend more than balance', () async {
      final repo = _MemoryProgressRepository()..progress = PlayerProgress(coins: 5);
      final service = EconomyService(repo);

      final ok = await service.trySpend(
        amount: 10,
        sink: CoinSink.hintTier1,
      );

      expect(ok, isFalse);
      expect((await repo.getProgress()).coins, 5);
    });
  });
}
