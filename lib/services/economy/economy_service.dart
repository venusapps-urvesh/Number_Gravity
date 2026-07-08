import '../../storage/adapters/player_progress.dart';
import '../../storage/repositories/progress_repository.dart';
import 'coin_service.dart';

class EconomyService {
  EconomyService(this._repository);

  final ProgressRepository _repository;

  Future<PlayerProgress> getProgress() => _repository.getProgress();

  Future<bool> canAfford(int amount) async {
    final progress = await _repository.getProgress();
    return progress.coins >= amount;
  }

  Future<bool> trySpend({
    required int amount,
    required CoinSink sink,
  }) async {
    if (amount <= 0) {
      return true;
    }
    final progress = await _repository.getProgress();
    if (progress.coins < amount) {
      return false;
    }
    progress.coins -= amount;
    await _repository.saveProgress(progress);
    return true;
  }

  Future<int> earn({
    required int amount,
    bool countsTowardLeaderboard = true,
  }) async {
    if (amount <= 0) {
      final progress = await _repository.getProgress();
      return progress.coins;
    }
    final progress = await _repository.getProgress();
    progress.coins += amount;
    if (countsTowardLeaderboard) {
      progress.gameplayEarnedCoins += amount;
    }
    await _repository.saveProgress(progress);
    return progress.coins;
  }
}
