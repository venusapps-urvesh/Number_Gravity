import 'package:hive/hive.dart';

import '../adapters/statistics_data.dart';
import '../hive_boxes.dart';
import 'statistics_repository.dart';

class HiveStatisticsRepository implements StatisticsRepository {
  HiveStatisticsRepository(this._box);

  final Box<StatisticsData> _box;

  static const String _statisticsKey = 'statistics';

  StatisticsData _read() => _box.get(_statisticsKey) ?? StatisticsData();

  Future<void> _write(StatisticsData data) async {
    await _box.put(_statisticsKey, data);
  }

  @override
  Future<StatisticsData> getStatistics() async => _read();

  @override
  Future<void> recordLevelStart() async {
    final stats = _read()..levelsStarted += 1;
    await _write(stats);
  }

  @override
  Future<void> recordLevelComplete() async {
    final stats = _read()..levelsCompleted += 1;
    await _write(stats);
  }

  @override
  Future<void> recordMove() async {
    final stats = _read()..totalMoves += 1;
    await _write(stats);
  }

  @override
  Future<void> recordHintUsed() async {
    final stats = _read()..hintsUsed += 1;
    await _write(stats);
  }

  @override
  Future<void> recordUndo() async {
    final stats = _read()..undosUsed += 1;
    await _write(stats);
  }
}

class StatisticsRepositoryFactory {
  static Future<HiveStatisticsRepository> create() async {
    final box = await Hive.openBox<StatisticsData>(HiveBoxes.statistics);
    return HiveStatisticsRepository(box);
  }
}
