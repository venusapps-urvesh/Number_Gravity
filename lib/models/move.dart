import 'package:freezed_annotation/freezed_annotation.dart';

part 'move.freezed.dart';
part 'move.g.dart';

enum Direction {
  up,
  down,
  left,
  right,
}

extension DirectionX on Direction {
  int get rowDelta => switch (this) {
        Direction.up => -1,
        Direction.down => 1,
        Direction.left => 0,
        Direction.right => 0,
      };

  int get colDelta => switch (this) {
        Direction.up => 0,
        Direction.down => 0,
        Direction.left => -1,
        Direction.right => 1,
      };

  String get shortCode => switch (this) {
        Direction.up => 'U',
        Direction.down => 'D',
        Direction.left => 'L',
        Direction.right => 'R',
      };

  static Direction? fromShortCode(String code) {
    switch (code.toUpperCase()) {
      case 'U':
        return Direction.up;
      case 'D':
        return Direction.down;
      case 'L':
        return Direction.left;
      case 'R':
        return Direction.right;
      default:
        return null;
    }
  }
}

@freezed
class Move with _$Move {
  const factory Move({
    required String tileId,
    required Direction direction,
  }) = _Move;

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);
}
