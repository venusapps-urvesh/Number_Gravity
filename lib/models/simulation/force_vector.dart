import 'package:freezed_annotation/freezed_annotation.dart';

import '../move.dart';

part 'force_vector.freezed.dart';
part 'force_vector.g.dart';

@freezed
class ForceVector with _$ForceVector {
  const factory ForceVector({
    required String sourceTileId,
    required String targetTileId,
    required double force,
    required Direction direction,
    required bool isRepulsion,
  }) = _ForceVector;

  factory ForceVector.fromJson(Map<String, dynamic> json) =>
      _$ForceVectorFromJson(json);
}
