import '../../core/constants/game_constants.dart';
import '../../storage/adapters/player_progress.dart';
import '../../storage/repositories/progress_repository.dart';
import 'coin_service.dart';

class EngagementService {
  EngagementService(this._repository);

  final ProgressRepository _repository;

  String _todayKey(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }

  Future<void> _resetDailyCountersIfNeeded(PlayerProgress progress) async {
    final today = _todayKey(DateTime.now());
    if (progress.rewardedAdsDate != today) {
      progress.rewardedAdsDate = today;
      progress.rewardedAdsToday = 0;
    }
    if (progress.shareDate != today) {
      progress.shareDate = today;
      progress.sharesToday = 0;
    }
  }

  Future<bool> canShowRewardedAd() async {
    final progress = await _repository.getProgress();
    await _resetDailyCountersIfNeeded(progress);
    return progress.rewardedAdsToday < maxRewardedAdsPerDay;
  }

  Future<int?> grantRewardedAdCoins() async {
    final progress = await _repository.getProgress();
    await _resetDailyCountersIfNeeded(progress);
    if (progress.rewardedAdsToday >= maxRewardedAdsPerDay) {
      return null;
    }
    progress.rewardedAdsToday += 1;
    progress.coins += coinsRewardedAd;
    await _repository.saveProgress(progress);
    return coinsRewardedAd;
  }

  Future<bool> canShareForReward() async {
    final progress = await _repository.getProgress();
    await _resetDailyCountersIfNeeded(progress);
    return progress.sharesToday < maxSharesPerDay;
  }

  Future<int?> grantShareReward() async {
    final progress = await _repository.getProgress();
    await _resetDailyCountersIfNeeded(progress);
    if (progress.sharesToday >= maxSharesPerDay) {
      return null;
    }
    progress.sharesToday += 1;
    progress.coins += coinsShareResult;
    progress.gameplayEarnedCoins += coinsShareResult;
    await _repository.saveProgress(progress);
    return coinsShareResult;
  }

  Future<bool> buyStreakFreeze() async {
    final progress = await _repository.getProgress();
    if (progress.coins < coinCostStreakFreeze) {
      return false;
    }
    progress.coins -= coinCostStreakFreeze;
    progress.streakFreezes += 1;
    await _repository.saveProgress(progress);
    return true;
  }

  Future<bool> useStreakFreeze() async {
    final progress = await _repository.getProgress();
    if (progress.streakFreezes <= 0) {
      return false;
    }
    progress.streakFreezes -= 1;
    progress.streakFreezeActive = true;
    await _repository.saveProgress(progress);
    return true;
  }

  Future<bool> skipLevel({required int levelId}) async {
    final progress = await _repository.getProgress();
    if (progress.coins < coinCostSkipLevel) {
      return false;
    }
    progress.coins -= coinCostSkipLevel;
    await _repository.setLevelStars(
      levelId: levelId,
      stars: 1,
      movesUsed: 999,
    );
    await _repository.saveProgress(progress);
    return true;
  }

  Future<int> purchaseCoins({
    required int amount,
    required CoinSource source,
  }) async {
    final progress = await _repository.getProgress();
    progress.coins += amount;
    if (source != CoinSource.iap && source != CoinSource.rewardedAd) {
      progress.gameplayEarnedCoins += amount;
    }
    await _repository.saveProgress(progress);
    return progress.coins;
  }
}
