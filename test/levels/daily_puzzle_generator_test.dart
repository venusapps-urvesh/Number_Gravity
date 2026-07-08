import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/levels/daily_puzzle_generator.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/objective_checker.dart';
import 'package:number_gravity/tooling/solver/move_encoder.dart';

void main() {
  group('DailyPuzzleGenerator', () {
    final generator = DailyPuzzleGenerator();
    final applier = BoardApplier();
    final engine = DefaultGravityEngine();
    const checker = ObjectiveChecker();

    test('generated puzzle has a solver-verified solution', () {
      final level = generator.generateForDate(DateTime(2026, 7, 7));
      expect(level.solutionMoves.length, level.minimumMoves);
      expect(level.solutionMoves.first, contains(':'));
    });

    test('generated solution solves the daily puzzle', () {
      final level = generator.generateForDate(DateTime(2026, 7, 7));
      var board = level.board;
      final defaultTile = switch (level.objective) {
        PositionObjective(:final tileId) => tileId,
        _ => 't1',
      };

      for (final code in level.solutionMoves) {
        final move = MoveEncoder.decodeStep(code, defaultTileId: defaultTile);
        board = engine.simulate(applier.applyPlayerMove(board, move)).finalBoard;
      }

      expect(checker.isSolved(level, board), isTrue);
    });
  });
}
