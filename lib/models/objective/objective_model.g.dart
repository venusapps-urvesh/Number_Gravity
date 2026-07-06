// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objective_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PositionObjectiveImpl _$$PositionObjectiveImplFromJson(
  Map<String, dynamic> json,
) => _$PositionObjectiveImpl(
  tileId: json['tileId'] as String,
  goalRow: (json['goalRow'] as num).toInt(),
  goalCol: (json['goalCol'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$PositionObjectiveImplToJson(
  _$PositionObjectiveImpl instance,
) => <String, dynamic>{
  'tileId': instance.tileId,
  'goalRow': instance.goalRow,
  'goalCol': instance.goalCol,
  'type': instance.$type,
};

_$SequenceObjectiveImpl _$$SequenceObjectiveImplFromJson(
  Map<String, dynamic> json,
) => _$SequenceObjectiveImpl(
  tileIds: (json['tileIds'] as List<dynamic>).map((e) => e as String).toList(),
  targetValues: (json['targetValues'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$SequenceObjectiveImplToJson(
  _$SequenceObjectiveImpl instance,
) => <String, dynamic>{
  'tileIds': instance.tileIds,
  'targetValues': instance.targetValues,
  'type': instance.$type,
};

_$SumObjectiveImpl _$$SumObjectiveImplFromJson(Map<String, dynamic> json) =>
    _$SumObjectiveImpl(
      tileIds: (json['tileIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      targetSum: (json['targetSum'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SumObjectiveImplToJson(_$SumObjectiveImpl instance) =>
    <String, dynamic>{
      'tileIds': instance.tileIds,
      'targetSum': instance.targetSum,
      'type': instance.$type,
    };

_$BalanceObjectiveImpl _$$BalanceObjectiveImplFromJson(
  Map<String, dynamic> json,
) => _$BalanceObjectiveImpl(
  regionTileIds: (json['regionTileIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  targetValue: (json['targetValue'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$BalanceObjectiveImplToJson(
  _$BalanceObjectiveImpl instance,
) => <String, dynamic>{
  'regionTileIds': instance.regionTileIds,
  'targetValue': instance.targetValue,
  'type': instance.$type,
};

_$CollectionObjectiveImpl _$$CollectionObjectiveImplFromJson(
  Map<String, dynamic> json,
) => _$CollectionObjectiveImpl(
  tileGoals: (json['tileGoals'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    ),
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$CollectionObjectiveImplToJson(
  _$CollectionObjectiveImpl instance,
) => <String, dynamic>{'tileGoals': instance.tileGoals, 'type': instance.$type};

_$ChainObjectiveImpl _$$ChainObjectiveImplFromJson(Map<String, dynamic> json) =>
    _$ChainObjectiveImpl(
      subObjectiveIds: (json['subObjectiveIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ChainObjectiveImplToJson(
  _$ChainObjectiveImpl instance,
) => <String, dynamic>{
  'subObjectiveIds': instance.subObjectiveIds,
  'type': instance.$type,
};
