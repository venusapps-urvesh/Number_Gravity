// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoveRecordImpl _$$MoveRecordImplFromJson(Map<String, dynamic> json) =>
    _$MoveRecordImpl(
      tileId: json['tileId'] as String,
      direction: $enumDecode(_$DirectionEnumMap, json['direction']),
    );

Map<String, dynamic> _$$MoveRecordImplToJson(_$MoveRecordImpl instance) =>
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
