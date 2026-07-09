import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/game/bridges/simulation_bridge.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';

void main() {
  group('SimulationBridge', () {
    final bridge = SimulationBridge(
      engine: DefaultGravityEngine(),
      applier: BoardApplier(),
    );

    test('preview and commit produce identical simulation output', () {
      final board = BoardModel(
        rows: 4,
        cols: 4,
        tiles: [
          const TileModel(
            id: 'a',
            type: TileType.number,
            value: 3,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 'b',
            type: TileType.number,
            value: 2,
            row: 3,
            col: 3,
          ),
        ],
      );
      const move = Move(tileId: 'a', direction: Direction.right);

      final preview = bridge.previewMove(board, move);
      final (commitResult, commitBoard) = bridge.commitMove(board, move);

      expect(preview.finalBoard.toFlatHash(), commitResult.finalBoard.toFlatHash());
      expect(commitBoard.toFlatHash(), commitResult.finalBoard.toFlatHash());
      expect(preview.steps.length, commitResult.steps.length);
    });
  });
}
