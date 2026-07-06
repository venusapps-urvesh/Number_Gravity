import 'package:hive/hive.dart';

import 'settings_data.dart';

class SettingsDataAdapter extends TypeAdapter<SettingsData> {
  @override
  final int typeId = 1;

  @override
  SettingsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsData(
      themeModeIndex: fields[0] as int? ?? 0,
      musicEnabled: fields[1] as bool? ?? true,
      sfxEnabled: fields[2] as bool? ?? true,
      colorBlindMode: fields[3] as bool? ?? false,
      reduceMotion: fields[4] as bool? ?? false,
      hapticsEnabled: fields[5] as bool? ?? true,
      localeCode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.themeModeIndex)
      ..writeByte(1)
      ..write(obj.musicEnabled)
      ..writeByte(2)
      ..write(obj.sfxEnabled)
      ..writeByte(3)
      ..write(obj.colorBlindMode)
      ..writeByte(4)
      ..write(obj.reduceMotion)
      ..writeByte(5)
      ..write(obj.hapticsEnabled)
      ..writeByte(6)
      ..write(obj.localeCode);
  }
}
