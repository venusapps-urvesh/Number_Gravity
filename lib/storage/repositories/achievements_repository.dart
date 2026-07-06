import '../adapters/achievement_record.dart';

abstract class AchievementsRepository {
  Future<List<AchievementRecord>> getUnlocked();

  Future<void> unlock(String achievementId);
}
