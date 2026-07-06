import '../models/move.dart';
import 'force_calculator.dart';

/// Resolves movement direction from forces per Section 2.3.
class TieBreaker {
  const TieBreaker();

  Direction? resolveMovement(DirectionalForceMap forces) {
    final vertical = _resolveAxis(
      positiveDirection: Direction.down,
      negativeDirection: Direction.up,
      positiveForce: forces.down,
      negativeForce: forces.up,
    );
    final horizontal = _resolveAxis(
      positiveDirection: Direction.right,
      negativeDirection: Direction.left,
      positiveForce: forces.right,
      negativeForce: forces.left,
    );

    if (vertical == null && horizontal == null) {
      return null;
    }
    if (vertical != null && horizontal == null) {
      return vertical;
    }
    if (vertical == null && horizontal != null) {
      return horizontal;
    }

    final verticalStrength = _axisStrength(forces, vertical!);
    final horizontalStrength = _axisStrength(forces, horizontal!);

    if (verticalStrength > horizontalStrength) {
      return vertical;
    }
    if (horizontalStrength > verticalStrength) {
      return horizontal;
    }

    // Equal pull on two axes → vertical before horizontal.
    return vertical;
  }

  Direction? _resolveAxis({
    required Direction positiveDirection,
    required Direction negativeDirection,
    required double positiveForce,
    required double negativeForce,
  }) {
    final attractionPositive = positiveForce > 0 ? positiveForce : 0.0;
    final attractionNegative = negativeForce > 0 ? negativeForce : 0.0;
    final repulsionPositive = positiveForce < 0 ? positiveForce.abs() : 0.0;
    final repulsionNegative = negativeForce < 0 ? negativeForce.abs() : 0.0;

    final totalAttraction = attractionPositive + attractionNegative;
    final totalRepulsion = repulsionPositive + repulsionNegative;

    if (totalAttraction == 0 && totalRepulsion == 0) {
      return null;
    }

    if (totalAttraction == totalRepulsion) {
      // Repulsion wins ties between attraction and repulsion.
      if (repulsionPositive >= repulsionNegative && repulsionPositive > 0) {
        return positiveDirection;
      }
      if (repulsionNegative > 0) {
        return negativeDirection;
      }
      return null;
    }

    if (totalRepulsion > totalAttraction) {
      if (repulsionPositive == repulsionNegative) {
        return null;
      }
      return repulsionPositive > repulsionNegative
          ? positiveDirection
          : negativeDirection;
    }

    if (attractionPositive == attractionNegative) {
      return null;
    }
    return attractionPositive > attractionNegative
        ? positiveDirection
        : negativeDirection;
  }

  double _axisStrength(DirectionalForceMap forces, Direction direction) {
    return switch (direction) {
      Direction.up => forces.up.abs(),
      Direction.down => forces.down.abs(),
      Direction.left => forces.left.abs(),
      Direction.right => forces.right.abs(),
    };
  }
}
