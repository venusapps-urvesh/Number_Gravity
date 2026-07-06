import 'package:flutter/material.dart';

import '../adapters/settings_data.dart';

abstract class SettingsRepository {
  Future<SettingsData> getSettings();

  Future<void> saveSettings(SettingsData settings);

  Future<ThemeMode> getThemeMode();

  Future<void> setThemeMode(ThemeMode mode);

  Future<bool> getColorBlindMode();

  Future<void> setColorBlindMode(bool enabled);

  Future<bool> getReduceMotion();

  Future<void> setReduceMotion(bool enabled);

  Future<String?> getLocaleCode();

  Future<void> setLocaleCode(String? code);
}
