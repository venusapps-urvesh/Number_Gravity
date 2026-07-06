// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardModelImpl _$$BoardModelImplFromJson(Map<String, dynamic> json) =>
    _$BoardModelImpl(
      rows: (json['rows'] as num).toInt(),
      cols: (json['cols'] as num).toInt(),
      tiles:
          (json['tiles'] as List<dynamic>?)
              ?.map((e) => TileModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BoardModelImplToJson(_$BoardModelImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'cols': instance.cols,
      'tiles': instance.tiles,
    };
