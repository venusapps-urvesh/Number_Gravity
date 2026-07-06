import 'package:hive/hive.dart';

import 'statistics_data.dart';

class StatisticsDataAdapter extends TypeAdapter<StatisticsData> {
  @override
  final int typeId = 4;

  @override
  StatisticsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatisticsData(
      totalMoves: fields[0] as int? ?? 0,
      levelsStarted: fields[1] as int? ?? 0,
      levelsCompleted: fields[2] as int? ?? 0,
      hintsUsed: fields[3] as int? ?? 0,
      undosUsed: fields[4] as int? ?? 0,
      totalPlayTimeSeconds: fields[5] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, StatisticsData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.totalMoves)
      ..writeByte(1)
      ..write(obj.levelsStarted)
      ..writeByte(2)
      ..write(obj.levelsCompleted)
      ..writeByte(3)
      ..write(obj.hintsUsed)
      ..writeByte(4)
      ..write(obj.undosUsed)
      ..writeByte(5)
      ..write(obj.totalPlayTimeSeconds);
  }
}
