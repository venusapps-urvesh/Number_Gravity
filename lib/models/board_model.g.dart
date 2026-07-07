// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
  rows: (json['rows'] as num).toInt(),
  cols: (json['cols'] as num).toInt(),
  tiles:
      (json['tiles'] as List<dynamic>?)
          ?.map((e) => TileModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'cols': instance.cols,
      'tiles': instance.tiles,
    };
