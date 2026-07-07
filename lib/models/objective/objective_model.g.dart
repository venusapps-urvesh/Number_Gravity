// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objective_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionObjective _$PositionObjectiveFromJson(Map<String, dynamic> json) =>
    PositionObjective(
      tileId: json['tileId'] as String,
      goalRow: (json['goalRow'] as num).toInt(),
      goalCol: (json['goalCol'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PositionObjectiveToJson(PositionObjective instance) =>
    <String, dynamic>{
      'tileId': instance.tileId,
      'goalRow': instance.goalRow,
      'goalCol': instance.goalCol,
      'type': instance.$type,
    };

SequenceObjective _$SequenceObjectiveFromJson(Map<String, dynamic> json) =>
    SequenceObjective(
      tileIds: (json['tileIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      targetValues: (json['targetValues'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SequenceObjectiveToJson(SequenceObjective instance) =>
    <String, dynamic>{
      'tileIds': instance.tileIds,
      'targetValues': instance.targetValues,
      'type': instance.$type,
    };

SumObjective _$SumObjectiveFromJson(Map<String, dynamic> json) => SumObjective(
  tileIds: (json['tileIds'] as List<dynamic>).map((e) => e as String).toList(),
  targetSum: (json['targetSum'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SumObjectiveToJson(SumObjective instance) =>
    <String, dynamic>{
      'tileIds': instance.tileIds,
      'targetSum': instance.targetSum,
      'type': instance.$type,
    };

BalanceObjective _$BalanceObjectiveFromJson(Map<String, dynamic> json) =>
    BalanceObjective(
      regionTileIds: (json['regionTileIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      targetValue: (json['targetValue'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$BalanceObjectiveToJson(BalanceObjective instance) =>
    <String, dynamic>{
      'regionTileIds': instance.regionTileIds,
      'targetValue': instance.targetValue,
      'type': instance.$type,
    };

CollectionObjective _$CollectionObjectiveFromJson(Map<String, dynamic> json) =>
    CollectionObjective(
      tileGoals: (json['tileGoals'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
        ),
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CollectionObjectiveToJson(
  CollectionObjective instance,
) => <String, dynamic>{'tileGoals': instance.tileGoals, 'type': instance.$type};

ChainObjective _$ChainObjectiveFromJson(Map<String, dynamic> json) =>
    ChainObjective(
      subObjectiveIds: (json['subObjectiveIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ChainObjectiveToJson(ChainObjective instance) =>
    <String, dynamic>{
      'subObjectiveIds': instance.subObjectiveIds,
      'type': instance.$type,
    };
