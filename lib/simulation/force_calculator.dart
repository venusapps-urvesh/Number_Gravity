import '../../core/constants/game_constants.dart';
import '../../models/board_model.dart';
import '../../models/move.dart';
import '../../models/tile_model.dart';
import '../../models/simulation/force_vector.dart';
import 'utils/board_utils.dart';

/// Computes gravity forces per production doc Section 2.1.
class ForceCalculator {
  const ForceCalculator();

  double forceMagnitude(int sourceValue, int distance) {
    if (distance <= 0 || distance >= forceRangeCap) {
      return 0;
    }
    return sourceValue.abs() / distance;
  }

  List<ForceVector> computeForces(BoardModel board, String tileId) {
    final target = board.tileById(tileId);
    if (target == null || !target.isMovable) {
      return const [];
    }

    final vectors = <ForceVector>[];
    for (final source in BoardUtils.gravitySources(board)) {
      vectors.addAll(_forcesFromSource(board, target, source));
    }
    return vectors;
  }

  List<ForceVector> _forcesFromSource(
    BoardModel board,
    TileModel target,
    TileModel source,
  ) {
    final dr = source.row - target.row;
    final dc = source.col - target.col;
    final distance = dr.abs() + dc.abs();
    final magnitude = forceMagnitude(source.value, distance);
    if (magnitude == 0) {
      return const [];
    }

    final isRepulsion = source.value < 0;
    final vectors = <ForceVector>[];

    if (dr != 0) {
      final direction = dr < 0 ? Direction.up : Direction.down;
      vectors.add(
        ForceVector(
          sourceTileId: source.id,
          targetTileId: target.id,
          force: magnitude,
          direction: direction,
          isRepulsion: isRepulsion,
        ),
      );
    }

    if (dc != 0) {
      final direction = dc < 0 ? Direction.left : Direction.right;
      vectors.add(
        ForceVector(
          sourceTileId: source.id,
          targetTileId: target.id,
          force: magnitude,
          direction: direction,
          isRepulsion: isRepulsion,
        ),
      );
    }

    return vectors;
  }

  /// Signed pull per direction: positive = wants to move that way.
  DirectionalForceMap computeDirectionalForces(
    BoardModel board,
    TileModel target,
  ) {
    final forces = DirectionalForceMap.zero();
    for (final vector in computeForces(board, target.id)) {
      final signed = vector.isRepulsion ? -vector.force : vector.force;
      forces.add(vector.direction, signed);
    }
    return forces;
  }
}

/// Net signed force per cardinal direction.
class DirectionalForceMap {
  DirectionalForceMap({
    required this.up,
    required this.down,
    required this.left,
    required this.right,
  });

  factory DirectionalForceMap.zero() {
    return DirectionalForceMap(up: 0, down: 0, left: 0, right: 0);
  }

  double up;
  double down;
  double left;
  double right;

  void add(Direction direction, double signedForce) {
    switch (direction) {
      case Direction.up:
        up += signedForce;
      case Direction.down:
        down += signedForce;
      case Direction.left:
        left += signedForce;
      case Direction.right:
        right += signedForce;
    }
  }

  bool get hasAnyForce =>
      up != 0 || down != 0 || left != 0 || right != 0;
}
