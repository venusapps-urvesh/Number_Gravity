import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/core/errors/app_exception.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/board_applier.dart';

void main() {
  group('BoardApplier', () {
    final applier = BoardApplier();

    BoardModel buildBoard() {
      return BoardModel(
        rows: 4,
        cols: 4,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 3,
            row: 1,
            col: 1,
          ),
          const TileModel(
            id: 'w1',
            type: TileType.wall,
            row: 1,
            col: 2,
          ),
        ],
      );
    }

    test('applyPlayerMove slides tile one cell', () {
      final board = buildBoard();
      final result = applier.applyPlayerMove(
        board,
        const Move(tileId: 't1', direction: Direction.left),
      );

      expect(result.tileAt(1, 0)?.id, 't1');
      expect(result.tileAt(1, 1), isNull);
    });

    test('applyPlayerMove blocks wall collision', () {
      final board = buildBoard();

      expect(
        () => applier.applyPlayerMove(
          board,
          const Move(tileId: 't1', direction: Direction.right),
        ),
        throwsA(isA<SimulationException>()),
      );
    });

    test('applyPlayerMove blocks boundary exit', () {
      final board = BoardModel(
        rows: 4,
        cols: 4,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 0,
            col: 0,
          ),
        ],
      );

      expect(
        () => applier.applyPlayerMove(
          board,
          const Move(tileId: 't1', direction: Direction.up),
        ),
        throwsA(isA<SimulationException>()),
      );
    });
  });
}
