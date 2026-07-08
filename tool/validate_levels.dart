#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:number_gravity/core/constants/game_constants.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/tooling/validator/level_validator.dart';

Future<void> main() async {
  final validator = LevelValidator();
  var valid = 0;
  var invalid = 0;

  for (var world = 1; world <= totalWorlds; world++) {
    final worldFile = File(
      'assets/levels/world_${world.toString().padLeft(2, '0')}.json',
    );
    if (!worldFile.existsSync()) {
      continue;
    }

    final decoded = jsonDecode(worldFile.readAsStringSync()) as Map<String, dynamic>;
    final levels = decoded['levels'] as List<dynamic>;

    for (final raw in levels) {
      final map = raw as Map<String, dynamic>;
      final level = _parseLevel(map);

      final solutionPath = File(
        'assets/levels/solutions/level_${level.id.toString().padLeft(3, '0')}.json',
      );
      final moves = solutionPath.existsSync()
          ? ((jsonDecode(solutionPath.readAsStringSync())
                  as Map<String, dynamic>)['solutionMoves'] as List<dynamic>)
              .map((m) => m as String)
              .toList()
          : (map['solutionMoves'] as List<dynamic>? ?? const [])
              .map((m) => m as String)
              .toList();

      final merged = level.copyWith(solutionMoves: moves);
      final result = validator.validate(merged);
      if (result.valid) {
        valid++;
      } else {
        invalid++;
        print(
          'Invalid level ${level.id}: ${result.issues.map((i) => i.label).join(', ')}',
        );
      }
    }
  }

  print('Validated $valid levels, $invalid invalid');
  if (invalid > 0) {
    exit(1);
  }
}

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
