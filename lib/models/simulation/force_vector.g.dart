// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_vector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForceVectorImpl _$$ForceVectorImplFromJson(Map<String, dynamic> json) =>
    _$ForceVectorImpl(
      sourceTileId: json['sourceTileId'] as String,
      targetTileId: json['targetTileId'] as String,
      force: (json['force'] as num).toDouble(),
      direction: $enumDecode(_$DirectionEnumMap, json['direction']),
      isRepulsion: json['isRepulsion'] as bool,
    );

Map<String, dynamic> _$$ForceVectorImplToJson(_$ForceVectorImpl instance) =>
    <String, dynamic>{
      'sourceTileId': instance.sourceTileId,
      'targetTileId': instance.targetTileId,
      'force': instance.force,
      'direction': _$DirectionEnumMap[instance.direction]!,
      'isRepulsion': instance.isRepulsion,
    };

const _$DirectionEnumMap = {
  Direction.up: 'up',
  Direction.down: 'down',
  Direction.left: 'left',
  Direction.right: 'right',
};
