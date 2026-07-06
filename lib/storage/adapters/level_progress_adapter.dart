import 'package:hive/hive.dart';

import 'level_progress.dart';

class LevelProgressAdapter extends TypeAdapter<LevelProgress> {
  @override
  final int typeId = 2;

  @override
  LevelProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LevelProgress(
      levelId: fields[0] as int,
      stars: fields[1] as int? ?? 0,
      isCompleted: fields[2] as bool? ?? false,
      bestMoves: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LevelProgress obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.levelId)
      ..writeByte(1)
      ..write(obj.stars)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.bestMoves);
  }
}
