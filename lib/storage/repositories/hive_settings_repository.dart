import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../adapters/settings_data.dart';
import '../hive_boxes.dart';
import 'settings_repository.dart';

class HiveSettingsRepository implements SettingsRepository {
  HiveSettingsRepository(this._box);

  final Box<SettingsData> _box;

  static const String _settingsKey = 'settings';

  @override
  Future<SettingsData> getSettings() async {
    return _box.get(_settingsKey) ?? SettingsData();
  }

  @override
  Future<void> saveSettings(SettingsData settings) async {
    await _box.put(_settingsKey, settings);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final settings = await getSettings();
    return ThemeMode.values[settings.themeModeIndex.clamp(0, 2)];
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final settings = await getSettings();
    settings.themeModeIndex = mode.index;
    await saveSettings(settings);
  }

  @override
  Future<bool> getColorBlindMode() async {
    final settings = await getSettings();
    return settings.colorBlindMode;
  }

  @override
  Future<void> setColorBlindMode(bool enabled) async {
    final settings = await getSettings();
    settings.colorBlindMode = enabled;
    await saveSettings(settings);
  }

  @override
  Future<bool> getReduceMotion() async {
    final settings = await getSettings();
    return settings.reduceMotion;
  }

  @override
  Future<void> setReduceMotion(bool enabled) async {
    final settings = await getSettings();
    settings.reduceMotion = enabled;
    await saveSettings(settings);
  }
}

class SettingsRepositoryFactory {
  static Future<HiveSettingsRepository> create() async {
    final box = await Hive.openBox<SettingsData>(HiveBoxes.settings);
    return HiveSettingsRepository(box);
  }
}
