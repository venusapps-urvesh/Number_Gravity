import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/core/constants/game_constants.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/objective_checker.dart';
import 'package:number_gravity/tooling/solver/move_encoder.dart';

LevelModel _parseLevel(Map<String, dynamic> json) {
  return LevelModel(
    id: json['id'] as int,
    world: json['world'] as int,
    tier: LevelTier.values.byName(json['tier'] as String),
    board: BoardModel(
      rows: json['rows'] as int,
      cols: json['cols'] as int,
      tiles: (json['tiles'] as List<dynamic>)
          .map((t) => TileModel.fromJson(t as Map<String, dynamic>))
          .toList(),
    ),
    objective: ObjectiveModel.fromJson(
      json['objective'] as Map<String, dynamic>,
    ),
    minimumMoves: json['minimumMoves'] as int,
    solutionMoves: (json['solutionMoves'] as List<dynamic>? ?? const [])
        .map((m) => m as String)
        .toList(),
  );
}

void main() {
  group('All launch levels solvable', () {
    final engine = DefaultGravityEngine();
    final applier = BoardApplier();
    const checker = ObjectiveChecker();

    test('all $totalLaunchLevels levels replay to solved state', () {
      for (var world = 1; world <= totalWorlds; world++) {
        final raw = File(
          'assets/levels/world_${world.toString().padLeft(2, '0')}.json',
        ).readAsStringSync();
        final levels = (jsonDecode(raw) as Map<String, dynamic>)['levels']
            as List<dynamic>;

        for (final entry in levels) {
          final level = _parseLevel(entry as Map<String, dynamic>);
          final solutionFile = File(
            'assets/levels/solutions/level_${level.id.toString().padLeft(3, '0')}.json',
          );
          expect(solutionFile.existsSync(), isTrue);

          final solutionJson =
              jsonDecode(solutionFile.readAsStringSync()) as Map<String, dynamic>;
          final codes = (solutionJson['solutionMoves'] as List<dynamic>)
              .map((m) => m as String)
              .toList();

          expect(codes.length, level.minimumMoves);

          var board = level.board;
          final defaultTile = switch (level.objective) {
            PositionObjective(:final tileId) => tileId,
            _ => 't1',
          };
          for (final code in codes) {
            final move = MoveEncoder.decodeStep(
              code,
              defaultTileId: defaultTile,
            );
            board = engine
                .simulate(applier.applyPlayerMove(board, move))
                .finalBoard;
          }

          expect(
            checker.isSolved(level, board),
            isTrue,
            reason: 'level ${level.id} failed',
          );
        }
      }
    });
  });
}
