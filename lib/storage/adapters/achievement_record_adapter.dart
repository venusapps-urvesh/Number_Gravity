import 'package:hive/hive.dart';

import 'achievement_record.dart';

class AchievementRecordAdapter extends TypeAdapter<AchievementRecord> {
  @override
  final int typeId = 5;

  @override
  AchievementRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AchievementRecord(
      id: fields[0] as String,
      unlockedAt: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AchievementRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.unlockedAt);
  }
}
