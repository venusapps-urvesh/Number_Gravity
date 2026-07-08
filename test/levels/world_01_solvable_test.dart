import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/move.dart';
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
  group('World 1 solvability', () {
    final engine = DefaultGravityEngine();
    final applier = BoardApplier();
    const checker = ObjectiveChecker();

    final raw = File('assets/levels/world_01.json').readAsStringSync();
    final levels = (jsonDecode(raw) as Map<String, dynamic>)['levels']
        as List<dynamic>;

    test('all 25 levels have multiple number tiles', () {
      for (final entry in levels) {
        final level = _parseLevel(entry as Map<String, dynamic>);
        final numbers =
            level.board.tiles.where((t) => t.type.name == 'number').length;
        expect(numbers, greaterThanOrEqualTo(2));
      }
    });

    test('every solution solves its level', () {
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
        for (final code in codes) {
          final move = MoveEncoder.decodeStep(
            code,
            defaultTileId: switch (level.objective) {
              PositionObjective(:final tileId) => tileId,
              _ => 't1',
            },
          );
          board = engine.simulate(applier.applyPlayerMove(board, move)).finalBoard;
        }

        expect(
          checker.isSolved(level, board),
          isTrue,
          reason: 'level ${level.id} solution failed',
        );
      }
    });
  });
}
