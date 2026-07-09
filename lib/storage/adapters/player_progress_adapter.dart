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
      questsDate: fields[7] as String?,
      completedQuestIds: (fields[8] as List?)?.cast<String>() ?? const [],
      rewardedAdsToday: fields[9] as int? ?? 0,
      rewardedAdsDate: fields[10] as String?,
      lastChestClaimDate: fields[11] as DateTime?,
      sharesToday: fields[12] as int? ?? 0,
      shareDate: fields[13] as String?,
      streakFreezes: fields[14] as int? ?? 0,
      streakFreezeActive: fields[15] as bool? ?? false,
      dailyPuzzleBestMoves: fields[16] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerProgress obj) {
    final serializedProgress = obj.levelProgress.map(
      (key, value) => MapEntry(key.toString(), value),
    );

    writer
      ..writeByte(17)
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
      ..write(obj.lastDailyPuzzleDate)
      ..writeByte(7)
      ..write(obj.questsDate)
      ..writeByte(8)
      ..write(obj.completedQuestIds)
      ..writeByte(9)
      ..write(obj.rewardedAdsToday)
      ..writeByte(10)
      ..write(obj.rewardedAdsDate)
      ..writeByte(11)
      ..write(obj.lastChestClaimDate)
      ..writeByte(12)
      ..write(obj.sharesToday)
      ..writeByte(13)
      ..write(obj.shareDate)
      ..writeByte(14)
      ..write(obj.streakFreezes)
      ..writeByte(15)
      ..write(obj.streakFreezeActive)
      ..writeByte(16)
      ..write(obj.dailyPuzzleBestMoves);
  }
}
