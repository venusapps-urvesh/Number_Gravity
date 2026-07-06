// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelModelImpl _$$LevelModelImplFromJson(Map<String, dynamic> json) =>
    _$LevelModelImpl(
      id: (json['id'] as num).toInt(),
      world: (json['world'] as num).toInt(),
      tier: $enumDecode(_$LevelTierEnumMap, json['tier']),
      board: BoardModel.fromJson(json['board'] as Map<String, dynamic>),
      objective: ObjectiveModel.fromJson(
        json['objective'] as Map<String, dynamic>,
      ),
      minimumMoves: (json['minimumMoves'] as num).toInt(),
      solutionMoves:
          (json['solutionMoves'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LevelModelImplToJson(_$LevelModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'world': instance.world,
      'tier': _$LevelTierEnumMap[instance.tier]!,
      'board': instance.board,
      'objective': instance.objective,
      'minimumMoves': instance.minimumMoves,
      'solutionMoves': instance.solutionMoves,
    };

const _$LevelTierEnumMap = {
  LevelTier.beginner: 'beginner',
  LevelTier.intermediate: 'intermediate',
  LevelTier.advanced: 'advanced',
  LevelTier.expert: 'expert',
};
