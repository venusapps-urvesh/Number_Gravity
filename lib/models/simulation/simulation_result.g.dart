// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationResultImpl _$$SimulationResultImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationResultImpl(
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => CycleStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  finalBoard: BoardModel.fromJson(json['finalBoard'] as Map<String, dynamic>),
  isStable: json['isStable'] as bool? ?? true,
  hitCycleCap: json['hitCycleCap'] as bool? ?? false,
);

Map<String, dynamic> _$$SimulationResultImplToJson(
  _$SimulationResultImpl instance,
) => <String, dynamic>{
  'steps': instance.steps,
  'finalBoard': instance.finalBoard,
  'isStable': instance.isStable,
  'hitCycleCap': instance.hitCycleCap,
};
