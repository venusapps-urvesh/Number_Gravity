import 'package:freezed_annotation/freezed_annotation.dart';

import '../board_model.dart';
import 'cycle_step.dart';

part 'simulation_result.freezed.dart';
part 'simulation_result.g.dart';

@freezed
abstract class SimulationResult with _$SimulationResult {
  const factory SimulationResult({
    @Default([]) List<CycleStep> steps,
    required BoardModel finalBoard,
    @Default(true) bool isStable,
    @Default(false) bool hitCycleCap,
  }) = _SimulationResult;

  factory SimulationResult.fromJson(Map<String, dynamic> json) =>
      _$SimulationResultFromJson(json);
}
