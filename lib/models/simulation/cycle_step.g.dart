// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CycleStepImpl _$$CycleStepImplFromJson(Map<String, dynamic> json) =>
    _$CycleStepImpl(
      cycleIndex: (json['cycleIndex'] as num).toInt(),
      actions:
          (json['actions'] as List<dynamic>?)
              ?.map((e) => TileAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      boardSnapshot: BoardModel.fromJson(
        json['boardSnapshot'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$CycleStepImplToJson(_$CycleStepImpl instance) =>
    <String, dynamic>{
      'cycleIndex': instance.cycleIndex,
      'actions': instance.actions,
      'boardSnapshot': instance.boardSnapshot,
    };
