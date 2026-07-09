import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/ghost_simulator.dart';
import 'package:number_gravity/simulation/rules/portal_processor.dart';

void main() {
  group('BoardModel background tiles', () {
    test('backgroundTileAt returns portal under movable', () {
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 1,
            col: 1,
          ),
          const TileModel(
            id: 'p1',
            type: TileType.portal,
            value: 0,
            row: 1,
            col: 1,
            isLocked: true,
            portalPairId: 'p2',
          ),
          const TileModel(
            id: 'p2',
            type: TileType.portal,
            value: 0,
            row: 2,
            col: 2,
            isLocked: true,
            portalPairId: 'p1',
          ),
        ],
      );

      expect(board.tileAt(1, 1)?.id, 't1');
      expect(board.backgroundTileAt(1, 1)?.id, 'p1');
      expect(board.tilesAt(1, 1).length, 2);
    });
  });

  group('PortalProcessor', () {
    test('teleports using background portal cell', () {
      const processor = PortalProcessor();
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 1,
            col: 1,
          ),
          const TileModel(
            id: 'p1',
            type: TileType.portal,
            value: 0,
            row: 1,
            col: 1,
            isLocked: true,
            portalPairId: 'p2',
          ),
          const TileModel(
            id: 'p2',
            type: TileType.portal,
            value: 0,
            row: 2,
            col: 2,
            isLocked: true,
            portalPairId: 'p1',
          ),
        ],
      );

      final tile = board.tileById('t1')!;
      final result = processor.process(
        board: board,
        tile: tile,
        row: 1,
        col: 1,
      );

      expect(result.action, isNotNull);
      expect(result.tile.row, 2);
      expect(result.tile.col, 2);
    });

    test('does not teleport into occupied exit cell', () {
      const processor = PortalProcessor();
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 1,
            col: 1,
          ),
          const TileModel(
            id: 'blocker',
            type: TileType.number,
            value: 4,
            row: 2,
            col: 2,
          ),
          const TileModel(
            id: 'p1',
            type: TileType.portal,
            value: 0,
            row: 1,
            col: 1,
            isLocked: true,
            portalPairId: 'p2',
          ),
          const TileModel(
            id: 'p2',
            type: TileType.portal,
            value: 0,
            row: 2,
            col: 2,
            isLocked: true,
            portalPairId: 'p1',
          ),
        ],
      );

      final tile = board.tileById('t1')!;
      final result = processor.process(
        board: board,
        tile: tile,
        row: 1,
        col: 1,
      );

      expect(result.action, isNull);
      expect(result.tile.row, 1);
      expect(result.tile.col, 1);
    });
  });

  group('GhostSimulator', () {
    test('preview is deterministic for same move', () {
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 3,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 't2',
            type: TileType.number,
            value: 2,
            row: 0,
            col: 2,
          ),
        ],
      );
      final simulator = GhostSimulator(engine: DefaultGravityEngine());
      const move = Move(tileId: 't1', direction: Direction.right);

      final a = simulator.preview(board, move);
      final b = simulator.preview(board, move);

      expect(a.finalBoard.toFlatHash(), b.finalBoard.toFlatHash());
    });
  });
}
