import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/force_calculator.dart';

void main() {
  group('ForceCalculator', () {
    const calculator = ForceCalculator();

    test('applies distance decay and range cap', () {
      expect(calculator.forceMagnitude(5, 1), 5);
      expect(calculator.forceMagnitude(5, 2), 2.5);
      expect(calculator.forceMagnitude(5, 3), closeTo(1.666, 0.01));
      expect(calculator.forceMagnitude(5, 4), 0);
      expect(calculator.forceMagnitude(5, 0), 0);
    });

    test('appendix A produces stronger force from closer source', () {
      final board = BoardModel(
        rows: 1,
        cols: 5,
        tiles: [
          const TileModel(
            id: 'p5',
            type: TileType.number,
            value: 5,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 'x',
            type: TileType.number,
            value: 1,
            row: 0,
            col: 2,
          ),
          const TileModel(
            id: 'p2',
            type: TileType.number,
            value: 2,
            row: 0,
            col: 4,
          ),
        ],
      );

      final forces = calculator.computeForces(board, 'x');
      final fromFive = forces.firstWhere((f) => f.sourceTileId == 'p5');
      final fromTwo = forces.firstWhere((f) => f.sourceTileId == 'p2');

      expect(fromFive.force, greaterThan(fromTwo.force));
      expect(fromFive.direction.name, 'left');
    });
  });

  group('DefaultGravityEngine appendix A', () {
    test('movable tile moves toward stronger positive source', () {
      final engine = DefaultGravityEngine();
      final board = BoardModel(
        rows: 1,
        cols: 5,
        tiles: [
          const TileModel(
            id: 'p5',
            type: TileType.number,
            value: 5,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 'x',
            type: TileType.number,
            value: 1,
            row: 0,
            col: 2,
          ),
          const TileModel(
            id: 'p2',
            type: TileType.number,
            value: 2,
            row: 0,
            col: 4,
          ),
        ],
      );

      final result = engine.simulate(board);

      expect(result.steps.any((s) => s.actions.isNotEmpty), isTrue);
      expect(result.isStable, isTrue);
      expect(result.hitCycleCap, isFalse);
      expect(result.finalBoard.toFlatHash(), isNotEmpty);
    });
  });
}
