import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/rules/collision_resolver.dart';

void main() {
  group('CollisionResolver', () {
    const resolver = CollisionResolver();

    test('same sign higher magnitude survives', () {
      final result = resolver.resolve(
        moving: const TileModel(
          id: 'a',
          type: TileType.number,
          value: 5,
          row: 0,
          col: 0,
        ),
        occupant: const TileModel(
          id: 'b',
          type: TileType.number,
          value: 2,
          row: 0,
          col: 1,
        ),
      );

      expect(result.isMoveOnly, isFalse);
      expect(result.kind, 'replaced');
      expect(result.survivor?.value, 5);
    });

    test('opposite equal magnitudes annihilate', () {
      final result = resolver.resolve(
        moving: const TileModel(
          id: 'a',
          type: TileType.number,
          value: 3,
          row: 0,
          col: 0,
        ),
        occupant: const TileModel(
          id: 'b',
          type: TileType.number,
          value: -3,
          row: 0,
          col: 1,
        ),
      );

      expect(result.isAnnihilated, isTrue);
    });
  });

  group('determinism', () {
    test('identical simulation yields identical results', () {
      final engine = DefaultGravityEngine();
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 'a',
            type: TileType.number,
            value: 4,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 'b',
            type: TileType.number,
            value: 2,
            row: 2,
            col: 2,
          ),
        ],
      );

      final first = engine.simulate(board);
      final second = engine.simulate(board);

      expect(first.finalBoard.toFlatHash(), second.finalBoard.toFlatHash());
      expect(first.steps.length, second.steps.length);
    });
  });
}
