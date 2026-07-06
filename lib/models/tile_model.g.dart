// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TileModelImpl _$$TileModelImplFromJson(Map<String, dynamic> json) =>
    _$TileModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TileTypeEnumMap, json['type']),
      value: (json['value'] as num?)?.toInt() ?? 0,
      row: (json['row'] as num).toInt(),
      col: (json['col'] as num).toInt(),
      isLocked: json['isLocked'] as bool? ?? false,
      portalPairId: json['portalPairId'] as String?,
      switchId: json['switchId'] as String?,
      doorId: json['doorId'] as String?,
      isDoorOpen: json['isDoorOpen'] as bool? ?? false,
      allowsMerge: json['allowsMerge'] as bool? ?? false,
      allowsSplit: json['allowsSplit'] as bool? ?? false,
      modifierFactor: (json['modifierFactor'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$TileModelImplToJson(_$TileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TileTypeEnumMap[instance.type]!,
      'value': instance.value,
      'row': instance.row,
      'col': instance.col,
      'isLocked': instance.isLocked,
      'portalPairId': instance.portalPairId,
      'switchId': instance.switchId,
      'doorId': instance.doorId,
      'isDoorOpen': instance.isDoorOpen,
      'allowsMerge': instance.allowsMerge,
      'allowsSplit': instance.allowsSplit,
      'modifierFactor': instance.modifierFactor,
    };

const _$TileTypeEnumMap = {
  TileType.number: 'number',
  TileType.wall: 'wall',
  TileType.portal: 'portal',
  TileType.multiplier: 'multiplier',
  TileType.divider: 'divider',
  TileType.inverter: 'inverter',
  TileType.freeze: 'freeze',
  TileType.switchTile: 'switchTile',
  TileType.door: 'door',
  TileType.goal: 'goal',
};
