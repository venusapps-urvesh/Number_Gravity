// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TileAction _$TileActionFromJson(Map<String, dynamic> json) => _TileAction(
  tileId: json['tileId'] as String,
  actionType: $enumDecode(_$TileActionTypeEnumMap, json['actionType']),
  fromRow: (json['fromRow'] as num).toInt(),
  fromCol: (json['fromCol'] as num).toInt(),
  toRow: (json['toRow'] as num).toInt(),
  toCol: (json['toCol'] as num).toInt(),
  resultingValue: (json['resultingValue'] as num?)?.toInt(),
  relatedTileId: json['relatedTileId'] as String?,
  direction: $enumDecodeNullable(_$DirectionEnumMap, json['direction']),
);

Map<String, dynamic> _$TileActionToJson(_TileAction instance) =>
    <String, dynamic>{
      'tileId': instance.tileId,
      'actionType': _$TileActionTypeEnumMap[instance.actionType]!,
      'fromRow': instance.fromRow,
      'fromCol': instance.fromCol,
      'toRow': instance.toRow,
      'toCol': instance.toCol,
      'resultingValue': instance.resultingValue,
      'relatedTileId': instance.relatedTileId,
      'direction': _$DirectionEnumMap[instance.direction],
    };

const _$TileActionTypeEnumMap = {
  TileActionType.move: 'move',
  TileActionType.collide: 'collide',
  TileActionType.merge: 'merge',
  TileActionType.split: 'split',
  TileActionType.annihilate: 'annihilate',
  TileActionType.portal: 'portal',
  TileActionType.modify: 'modify',
  TileActionType.invert: 'invert',
  TileActionType.toggle: 'toggle',
};

const _$DirectionEnumMap = {
  Direction.up: 'up',
  Direction.down: 'down',
  Direction.left: 'left',
  Direction.right: 'right',
};
