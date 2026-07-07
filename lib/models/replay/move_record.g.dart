// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoveRecord _$MoveRecordFromJson(Map<String, dynamic> json) => _MoveRecord(
  tileId: json['tileId'] as String,
  direction: $enumDecode(_$DirectionEnumMap, json['direction']),
);

Map<String, dynamic> _$MoveRecordToJson(_MoveRecord instance) =>
    <String, dynamic>{
      'tileId': instance.tileId,
      'direction': _$DirectionEnumMap[instance.direction]!,
    };

const _$DirectionEnumMap = {
  Direction.up: 'up',
  Direction.down: 'down',
  Direction.left: 'left',
  Direction.right: 'right',
};
