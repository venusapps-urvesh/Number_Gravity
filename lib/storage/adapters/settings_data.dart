import 'package:hive/hive.dart';

class SettingsData extends HiveObject {
  SettingsData({
    this.themeModeIndex = 0,
    this.musicEnabled = true,
    this.sfxEnabled = true,
    this.colorBlindMode = false,
    this.reduceMotion = false,
    this.hapticsEnabled = true,
    this.localeCode,
  });

  int themeModeIndex;
  bool musicEnabled;
  bool sfxEnabled;
  bool colorBlindMode;
  bool reduceMotion;
  bool hapticsEnabled;
  String? localeCode;
}
