import 'package:freezed_annotation/freezed_annotation.dart';

import '../board_model.dart';
import '../objective/objective_model.dart';
import 'level_tier.dart';

part 'level_model.freezed.dart';
part 'level_model.g.dart';

@freezed
abstract class LevelModel with _$LevelModel {
  const factory LevelModel({
    required int id,
    required int world,
    required LevelTier tier,
    required BoardModel board,
    required ObjectiveModel objective,
    required int minimumMoves,
    @Default([]) List<String> solutionMoves,
  }) = _LevelModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
}
