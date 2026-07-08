import 'package:hive/hive.dart';

import 'level_progress.dart';
import 'player_progress.dart';

class PlayerProgressAdapter extends TypeAdapter<PlayerProgress> {
  @override
  final int typeId = 3;

  @override
  PlayerProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    final rawProgress = fields[3] as Map?;
    final levelProgress = <int, LevelProgress>{};
    rawProgress?.forEach((key, value) {
      levelProgress[int.parse(key.toString())] = value as LevelProgress;
    });

    return PlayerProgress(
      coins: fields[0] as int? ?? 0,
      gameplayEarnedCoins: fields[1] as int? ?? 0,
      unlockedWorlds: (fields[2] as List?)?.cast<int>() ?? const [1],
      levelProgress: levelProgress,
      dailyStreak: fields[4] as int? ?? 0,
      lastDailyLoginDate: fields[5] as String?,
      lastDailyPuzzleDate: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerProgress obj) {
    final serializedProgress = obj.levelProgress.map(
      (key, value) => MapEntry(key.toString(), value),
    );

    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.coins)
      ..writeByte(1)
      ..write(obj.gameplayEarnedCoins)
      ..writeByte(2)
      ..write(obj.unlockedWorlds)
      ..writeByte(3)
      ..write(serializedProgress)
      ..writeByte(4)
      ..write(obj.dailyStreak)
      ..writeByte(5)
      ..write(obj.lastDailyLoginDate)
      ..writeByte(6)
      ..write(obj.lastDailyPuzzleDate);
  }
}
