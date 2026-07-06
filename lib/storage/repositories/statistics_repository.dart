import '../adapters/statistics_data.dart';

abstract class StatisticsRepository {
  Future<StatisticsData> getStatistics();

  Future<void> recordLevelStart();

  Future<void> recordLevelComplete();

  Future<void> recordMove();

  Future<void> recordHintUsed();

  Future<void> recordUndo();
}
