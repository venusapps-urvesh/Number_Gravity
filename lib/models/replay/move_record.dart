import 'package:freezed_annotation/freezed_annotation.dart';

import '../move.dart';

part 'move_record.freezed.dart';
part 'move_record.g.dart';

@freezed
abstract class MoveRecord with _$MoveRecord {
  const factory MoveRecord({
    required String tileId,
    required Direction direction,
  }) = _MoveRecord;

  factory MoveRecord.fromJson(Map<String, dynamic> json) =>
      _$MoveRecordFromJson(json);
}
