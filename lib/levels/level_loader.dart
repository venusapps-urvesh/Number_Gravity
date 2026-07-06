import 'dart:convert';

import 'package:flutter/services.dart';

import '../core/constants/game_constants.dart';
import '../core/errors/app_exception.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/level/level_tier.dart';
import '../models/objective/objective_model.dart';
import '../models/tile_model.dart';

class LevelLoader {
  LevelModel parseLevel(Map<String, dynamic> json) {
    _validateLevelJson(json);

    final board = BoardModel(
      rows: json['rows'] as int,
      cols: json['cols'] as int,
      tiles: (json['tiles'] as List<dynamic>)
          .map((tile) => TileModel.fromJson(tile as Map<String, dynamic>))
          .toList(growable: false),
    );

    return LevelModel(
      id: json['id'] as int,
      world: json['world'] as int,
      tier: LevelTier.values.byName(json['tier'] as String),
      board: board,
      objective: ObjectiveModel.fromJson(
        json['objective'] as Map<String, dynamic>,
      ),
      minimumMoves: json['minimumMoves'] as int,
      solutionMoves: (json['solutionMoves'] as List<dynamic>? ?? const [])
          .map((move) => move as String)
          .toList(growable: false),
    );
  }

  Future<List<LevelModel>> loadWorldFromAsset(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final levels = decoded['levels'] as List<dynamic>? ?? const [];

    return levels
        .map((level) => parseLevel(level as Map<String, dynamic>))
        .toList(growable: false);
  }

  void _validateLevelJson(Map<String, dynamic> json) {
    final requiredKeys = [
      'id',
      'world',
      'tier',
      'rows',
      'cols',
      'objective',
      'tiles',
      'minimumMoves',
    ];

    for (final key in requiredKeys) {
      if (!json.containsKey(key)) {
        throw LevelLoadException('Missing required level field: $key');
      }
    }

    final rows = json['rows'] as int;
    final cols = json['cols'] as int;

    if (rows <= 0 || cols <= 0 || rows > maxBoardRows || cols > maxBoardCols) {
      throw LevelLoadException('Invalid board size: ${rows}x$cols');
    }

    final tiles = json['tiles'] as List<dynamic>;
    if (tiles.length > maxTiles) {
      throw LevelLoadException('Too many tiles: ${tiles.length}');
    }

    final objective = json['objective'] as Map<String, dynamic>;
    if (!objective.containsKey('type')) {
      throw LevelLoadException('Objective must include a type');
    }
  }
}
