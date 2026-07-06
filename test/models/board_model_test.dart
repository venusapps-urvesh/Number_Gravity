import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';

void main() {
  group('BoardModel', () {
    final board = BoardModel(
      rows: 4,
      cols: 4,
      tiles: [
        const TileModel(
          id: 't1',
          type: TileType.number,
          value: 3,
          row: 0,
          col: 0,
        ),
        const TileModel(
          id: 'w1',
          type: TileType.wall,
          row: 1,
          col: 1,
        ),
      ],
    );

    test('tileAt returns tile in cell', () {
      expect(board.tileAt(0, 0)?.id, 't1');
      expect(board.tileAt(1, 1)?.id, 'w1');
      expect(board.tileAt(2, 2), isNull);
    });

    test('copyWithTileAt returns new immutable board', () {
      final updated = board.copyWithTileAt(tileId: 't1', row: 0, col: 1);
      expect(updated.tileAt(0, 1)?.id, 't1');
      expect(board.tileAt(0, 1), isNull);
    });

    test('toFlatHash is deterministic', () {
      expect(board.toFlatHash(), board.toFlatHash());
    });
  });
}
