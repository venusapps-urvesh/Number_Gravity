import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../levels/asset_level_repository.dart';
import '../levels/level_repository.dart';
import '../services/replay/replay_service.dart';
import '../simulation/board_applier.dart';
import '../simulation/default_gravity_engine.dart';
import '../simulation/gravity_engine.dart';
import '../simulation/simulation_service.dart';
import '../storage/repositories/achievements_repository.dart';
import '../storage/repositories/progress_repository.dart';
import '../storage/repositories/settings_repository.dart';
import '../storage/repositories/statistics_repository.dart';
import '../storage/storage_initializer.dart';

final storageInitProvider = FutureProvider<StorageContainer>((ref) async {
  return initializeStorage();
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final storage = ref.watch(storageInitProvider).requireValue;
  return storage.settingsRepository;
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final storage = ref.watch(storageInitProvider).requireValue;
  return storage.progressRepository;
});

final statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  final storage = ref.watch(storageInitProvider).requireValue;
  return storage.statisticsRepository;
});

final achievementsRepositoryProvider = Provider<AchievementsRepository>((ref) {
  final storage = ref.watch(storageInitProvider).requireValue;
  return storage.achievementsRepository;
});

final levelRepositoryProvider = Provider<LevelRepository>((ref) {
  return AssetLevelRepository();
});

final gravityEngineProvider = Provider<GravityEngine>((ref) {
  return DefaultGravityEngine();
});

final boardApplierProvider = Provider<BoardApplier>((ref) {
  return BoardApplier();
});

final simulationServiceProvider = Provider<SimulationService>((ref) {
  return SimulationService(
    engine: ref.watch(gravityEngineProvider),
    applier: ref.watch(boardApplierProvider),
  );
});

final replayServiceProvider = Provider<ReplayService>((ref) {
  return ReplayService(engine: ref.watch(gravityEngineProvider));
});

final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    await ref.watch(storageInitProvider.future);
    final repository = ref.read(settingsRepositoryProvider);
    return repository.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setThemeMode(mode);
    state = AsyncData(mode);
  }
}

final colorBlindModeProvider =
    AsyncNotifierProvider<ColorBlindModeNotifier, bool>(
  ColorBlindModeNotifier.new,
);

class ColorBlindModeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    await ref.watch(storageInitProvider.future);
    return ref.read(settingsRepositoryProvider).getColorBlindMode();
  }

  Future<void> setEnabled(bool enabled) async {
    await ref.read(settingsRepositoryProvider).setColorBlindMode(enabled);
    state = AsyncData(enabled);
  }
}

final reduceMotionProvider =
    AsyncNotifierProvider<ReduceMotionNotifier, bool>(ReduceMotionNotifier.new);

final localeProvider =
    AsyncNotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

final playerProgressProvider = FutureProvider((ref) async {
  await ref.watch(storageInitProvider.future);
  return ref.read(progressRepositoryProvider).getProgress();
});

class ReduceMotionNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    await ref.watch(storageInitProvider.future);
    return ref.read(settingsRepositoryProvider).getReduceMotion();
  }

  Future<void> setEnabled(bool enabled) async {
    await ref.read(settingsRepositoryProvider).setReduceMotion(enabled);
    state = AsyncData(enabled);
  }
}

class LocaleNotifier extends AsyncNotifier<Locale?> {
  @override
  Future<Locale?> build() async {
    await ref.watch(storageInitProvider.future);
    final code = await ref.read(settingsRepositoryProvider).getLocaleCode();
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  Future<void> setLocale(Locale locale) async {
    await ref.read(settingsRepositoryProvider).setLocaleCode(locale.languageCode);
    state = AsyncData(locale);
  }
}
