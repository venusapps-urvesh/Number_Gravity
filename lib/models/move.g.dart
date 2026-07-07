// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Move _$MoveFromJson(Map<String, dynamic> json) => _Move(
  tileId: json['tileId'] as String,
  direction: $enumDecode(_$DirectionEnumMap, json['direction']),
);

Map<String, dynamic> _$MoveToJson(_Move instance) => <String, dynamic>{
  'tileId': instance.tileId,
  'direction': _$DirectionEnumMap[instance.direction]!,
};

const _$DirectionEnumMap = {
  Direction.up: 'up',
  Direction.down: 'down',
  Direction.left: 'left',
  Direction.right: 'right',
};
