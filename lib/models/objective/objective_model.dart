import 'package:freezed_annotation/freezed_annotation.dart';

import 'objective_type.dart';

part 'objective_model.freezed.dart';
part 'objective_model.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class ObjectiveModel with _$ObjectiveModel {
  const ObjectiveModel._();

  @FreezedUnionValue('position')
  const factory ObjectiveModel.position({
    required String tileId,
    required int goalRow,
    required int goalCol,
  }) = PositionObjective;

  @FreezedUnionValue('sequence')
  const factory ObjectiveModel.sequence({
    required List<String> tileIds,
    required List<int> targetValues,
  }) = SequenceObjective;

  @FreezedUnionValue('sum')
  const factory ObjectiveModel.sum({
    required List<String> tileIds,
    required int targetSum,
  }) = SumObjective;

  @FreezedUnionValue('balance')
  const factory ObjectiveModel.balance({
    required List<String> regionTileIds,
    required int targetValue,
  }) = BalanceObjective;

  @FreezedUnionValue('collection')
  const factory ObjectiveModel.collection({
    required Map<String, List<int>> tileGoals,
  }) = CollectionObjective;

  @FreezedUnionValue('chain')
  const factory ObjectiveModel.chain({
    required List<String> subObjectiveIds,
  }) = ChainObjective;

  factory ObjectiveModel.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveModelFromJson(json);

  ObjectiveType get type {
    return switch (this) {
      PositionObjective() => ObjectiveType.position,
      SequenceObjective() => ObjectiveType.sequence,
      SumObjective() => ObjectiveType.sum,
      BalanceObjective() => ObjectiveType.balance,
      CollectionObjective() => ObjectiveType.collection,
      ChainObjective() => ObjectiveType.chain,
    };
  }
}
