import 'package:hive/hive.dart';

import '../adapters/level_progress.dart';
import '../adapters/player_progress.dart';
import '../hive_boxes.dart';
import 'progress_repository.dart';

class HiveProgressRepository implements ProgressRepository {
  HiveProgressRepository(this._box);

  final Box<PlayerProgress> _box;

  static const String progressKey = 'progress';

  PlayerProgress _read() => _box.get(progressKey) ?? PlayerProgress();

  @override
  Future<PlayerProgress> getProgress() async => _read();

  @override
  Future<void> saveProgress(PlayerProgress progress) async {
    await _box.put(progressKey, progress);
  }

  @override
  Future<int> getLevelStars(int levelId) async {
    final progress = _read();
    return progress.levelProgress[levelId]?.stars ?? 0;
  }

  @override
  Future<void> setLevelStars({
    required int levelId,
    required int stars,
    int? movesUsed,
  }) async {
    final progress = _read();
    final existing = progress.levelProgress[levelId];
    final updated = LevelProgress(
      levelId: levelId,
      stars: stars > (existing?.stars ?? 0) ? stars : (existing?.stars ?? 0),
      isCompleted: true,
      bestMoves: _bestMoves(existing?.bestMoves, movesUsed),
    );

    progress.levelProgress = {
      ...progress.levelProgress,
      levelId: updated,
    };
    await saveProgress(progress);
  }

  int? _bestMoves(int? currentBest, int? movesUsed) {
    if (movesUsed == null) {
      return currentBest;
    }
    if (currentBest == null || movesUsed < currentBest) {
      return movesUsed;
    }
    return currentBest;
  }

  @override
  Future<bool> isLevelUnlocked(int levelId) async {
    if (levelId <= 1) {
      return true;
    }

    final progress = _read();
    final previous = progress.levelProgress[levelId - 1];
    return previous?.isCompleted ?? false;
  }

  @override
  Future<void> unlockWorld(int worldId) async {
    final progress = _read();
    if (progress.unlockedWorlds.contains(worldId)) {
      return;
    }
    progress.unlockedWorlds = [...progress.unlockedWorlds, worldId];
    await saveProgress(progress);
  }
}

class ProgressRepositoryFactory {
  static Future<HiveProgressRepository> create() async {
    final box = await Hive.openBox<PlayerProgress>(HiveBoxes.playerProgress);
    if (!box.containsKey(HiveProgressRepository.progressKey)) {
      await box.put(HiveProgressRepository.progressKey, PlayerProgress());
    }
    return HiveProgressRepository(box);
  }
}
