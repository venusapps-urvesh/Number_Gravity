import '../adapters/player_progress.dart';

abstract class ProgressRepository {
  Future<PlayerProgress> getProgress();

  Future<void> saveProgress(PlayerProgress progress);

  Future<int> getLevelStars(int levelId);

  Future<void> setLevelStars({
    required int levelId,
    required int stars,
    int? movesUsed,
  });

  Future<bool> isLevelUnlocked(int levelId);

  Future<void> unlockWorld(int worldId);
}
