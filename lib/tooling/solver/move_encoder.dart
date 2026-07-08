import '../../models/move.dart';

/// Encodes solver output for level JSON and solution files.
///
/// Multi-tile solutions use `tileId:Direction` (e.g. `t1:R`).
/// Legacy single-tile solutions may use direction only (e.g. `R`).
class MoveEncoder {
  const MoveEncoder._();

  static List<String> encode(List<Move> moves) {
    return moves
        .map((m) => '${m.tileId}:${m.direction.shortCode}')
        .toList(growable: false);
  }

  static List<Move> decode(
    List<String> codes, {
    String defaultTileId = 't1',
  }) {
    return codes
        .map((code) => decodeStep(code, defaultTileId: defaultTileId))
        .toList(growable: false);
  }

  static Move decodeStep(String code, {String defaultTileId = 't1'}) {
    final trimmed = code.trim();
    if (trimmed.contains(':')) {
      final parts = trimmed.split(':');
      final tileId = parts[0];
      final direction = DirectionX.fromShortCode(parts[1]);
      if (direction == null) {
        throw FormatException('Invalid direction in move code: $code');
      }
      return Move(tileId: tileId, direction: direction);
    }

    final direction = DirectionX.fromShortCode(trimmed);
    if (direction == null) {
      throw FormatException('Invalid move code: $code');
    }
    return Move(tileId: defaultTileId, direction: direction);
  }
}
