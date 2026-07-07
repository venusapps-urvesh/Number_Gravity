import 'package:freezed_annotation/freezed_annotation.dart';

import '../board_model.dart';
import 'tile_action.dart';

part 'cycle_step.freezed.dart';
part 'cycle_step.g.dart';

@freezed
abstract class CycleStep with _$CycleStep {
  const factory CycleStep({
    required int cycleIndex,
    @Default([]) List<TileAction> actions,
    required BoardModel boardSnapshot,
  }) = _CycleStep;

  factory CycleStep.fromJson(Map<String, dynamic> json) =>
      _$CycleStepFromJson(json);
}
