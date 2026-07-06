import 'package:hive_flutter/hive_flutter.dart';

import 'adapters/achievement_record_adapter.dart';
import 'adapters/level_progress_adapter.dart';
import 'adapters/player_progress_adapter.dart';
import 'adapters/settings_data_adapter.dart';
import 'adapters/statistics_data_adapter.dart';
import 'repositories/achievements_repository.dart';
import 'repositories/hive_achievements_repository.dart';
import 'repositories/hive_progress_repository.dart';
import 'repositories/hive_settings_repository.dart';
import 'repositories/hive_statistics_repository.dart';
import 'repositories/progress_repository.dart';
import 'repositories/settings_repository.dart';
import 'repositories/statistics_repository.dart';

class StorageContainer {
  const StorageContainer({
    required this.settingsRepository,
    required this.progressRepository,
    required this.statisticsRepository,
    required this.achievementsRepository,
  });

  final SettingsRepository settingsRepository;
  final ProgressRepository progressRepository;
  final StatisticsRepository statisticsRepository;
  final AchievementsRepository achievementsRepository;
}

Future<StorageContainer> initializeStorage() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(SettingsDataAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(LevelProgressAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(PlayerProgressAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(StatisticsDataAdapter());
  }
  if (!Hive.isAdapterRegistered(5)) {
    Hive.registerAdapter(AchievementRecordAdapter());
  }

  final settingsRepository = await SettingsRepositoryFactory.create();
  final progressRepository = await ProgressRepositoryFactory.create();
  final statisticsRepository = await StatisticsRepositoryFactory.create();
  final achievementsRepository = await AchievementsRepositoryFactory.create();

  return StorageContainer(
    settingsRepository: settingsRepository,
    progressRepository: progressRepository,
    statisticsRepository: statisticsRepository,
    achievementsRepository: achievementsRepository,
  );
}
