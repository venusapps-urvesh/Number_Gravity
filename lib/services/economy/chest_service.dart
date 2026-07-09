import '../../core/constants/game_constants.dart';
import '../../storage/repositories/progress_repository.dart';

class ChestService {
  ChestService(this._repository);

  final ProgressRepository _repository;

  Future<Duration?> cooldownRemaining() async {
    final progress = await _repository.getProgress();
    final last = progress.lastChestClaimDate;
    if (last == null) {
      return null;
    }
    final next = last.add(const Duration(hours: chestCooldownHours));
    final remaining = next.difference(DateTime.now());
    return remaining.isNegative ? null : remaining;
  }

  Future<bool> canClaim() async {
    final remaining = await cooldownRemaining();
    return remaining == null;
  }

  Future<int?> claim() async {
    if (!await canClaim()) {
      return null;
    }
    final progress = await _repository.getProgress();
    progress.coins += coinsTimeChest;
    progress.gameplayEarnedCoins += coinsTimeChest;
    progress.lastChestClaimDate = DateTime.now();
    await _repository.saveProgress(progress);
    return coinsTimeChest;
  }
}
