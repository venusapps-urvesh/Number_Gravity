import 'package:hive/hive.dart';

import '../adapters/achievement_record.dart';
import '../hive_boxes.dart';
import 'achievements_repository.dart';

class HiveAchievementsRepository implements AchievementsRepository {
  HiveAchievementsRepository(this._box);

  final Box<AchievementRecord> _box;

  @override
  Future<List<AchievementRecord>> getUnlocked() async {
    return _box.values.where((record) => record.unlockedAt != null).toList();
  }

  @override
  Future<void> unlock(String achievementId) async {
    final existing = _box.get(achievementId);
    if (existing?.unlockedAt != null) {
      return;
    }

    await _box.put(
      achievementId,
      AchievementRecord(
        id: achievementId,
        unlockedAt: DateTime.now(),
      ),
    );
  }
}

class AchievementsRepositoryFactory {
  static Future<HiveAchievementsRepository> create() async {
    final box = await Hive.openBox<AchievementRecord>(HiveBoxes.achievements);
    return HiveAchievementsRepository(box);
  }
}
