// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimulationResult _$SimulationResultFromJson(Map<String, dynamic> json) =>
    _SimulationResult(
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => CycleStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      finalBoard: BoardModel.fromJson(
        json['finalBoard'] as Map<String, dynamic>,
      ),
      isStable: json['isStable'] as bool? ?? true,
      hitCycleCap: json['hitCycleCap'] as bool? ?? false,
    );

Map<String, dynamic> _$SimulationResultToJson(_SimulationResult instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'finalBoard': instance.finalBoard,
      'isStable': instance.isStable,
      'hitCycleCap': instance.hitCycleCap,
    };
