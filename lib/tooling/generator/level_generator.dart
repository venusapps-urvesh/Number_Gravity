import 'dart:math';

import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/level/level_tier.dart';
import '../../models/objective/objective_model.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';
import '../analyzer/difficulty_analyzer.dart';
import '../analyzer/tier_tolerance.dart';
import '../solver/level_solver.dart';
import '../solver/move_encoder.dart';
import '../validator/level_validator.dart';
import 'world_templates.dart';

class GeneratedLevel {
  const GeneratedLevel({
    required this.levelJson,
    required this.solutionJson,
  });

  final Map<String, dynamic> levelJson;
  final Map<String, dynamic> solutionJson;
}

/// Procedural level builder with solver verification.
class LevelGenerator {
  LevelGenerator({
    LevelSolver? solver,
    LevelValidator? validator,
    DifficultyAnalyzer? analyzer,
    Random? random,
  })  : _solver = solver ?? LevelSolver(),
        _validator = validator ?? LevelValidator(),
        _analyzer = analyzer ?? DifficultyAnalyzer(),
        _random = random ?? Random();

  final LevelSolver _solver;
  final LevelValidator _validator;
  final DifficultyAnalyzer _analyzer;
  final Random _random;

  GeneratedLevel? generate({
    required int levelId,
    required int worldId,
    required int indexInWorld,
    int maxAttempts = 2000,
  }) {
    final template = templateForWorld(worldId);
    final primaryKind = objectiveKindForLevel(worldId, indexInWorld);
    final kinds = primaryKind == GeneratedObjectiveKind.position
        ? [primaryKind]
        : [primaryKind, GeneratedObjectiveKind.position];

    for (final kind in kinds) {
      final attempts = kind != GeneratedObjectiveKind.position &&
              kind == primaryKind
          ? maxAttempts ~/ 5
          : maxAttempts;
      final result = _generateWithObjective(
        levelId: levelId,
        worldId: worldId,
        indexInWorld: indexInWorld,
        template: template,
        objectiveKind: kind,
        maxAttempts: attempts,
      );
      if (result != null) {
        return result;
      }
    }

    return null;
  }

  GeneratedLevel? _generateWithObjective({
    required int levelId,
    required int worldId,
    required int indexInWorld,
    required WorldTemplate template,
    required GeneratedObjectiveKind objectiveKind,
    required int maxAttempts,
  }) {
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final seed = levelId * 1000 + attempt + objectiveKind.index * 100000;
      final rng = Random(seed);
      final level = _buildCandidate(
        levelId: levelId,
        worldId: worldId,
        indexInWorld: indexInWorld,
        template: template,
        objectiveKind: objectiveKind,
        rng: rng,
      );
      if (level == null) {
        continue;
      }

      final solverResult = _solver.solve(level);
      if (!solverResult.solved) {
        continue;
      }
      if (solverResult.minimumMoves < template.minSolutionMoves ||
          solverResult.minimumMoves > _maxSolutionMoves(template, indexInWorld)) {
        continue;
      }

      final encoded = MoveEncoder.encode(solverResult.moves);
      final solvedLevel = level.copyWith(
        minimumMoves: solverResult.minimumMoves,
        solutionMoves: encoded,
      );

      final validation = _validator.validate(solvedLevel);
      if (!validation.valid) {
        continue;
      }

      final analyzed = _analyzer.analyze(solvedLevel);
      final tierBands = template.worldId >= 6 ? 2 : 1;
      if (!tierWithinTolerance(
        template.tier.name,
        analyzed.tier,
        bands: tierBands,
      )) {
        continue;
      }

      final levelJson = _toLevelJson(solvedLevel, analyzed.tier);
      final solutionJson = {
        'levelId': levelId,
        'solutionMoves': encoded,
      };

      return GeneratedLevel(levelJson: levelJson, solutionJson: solutionJson);
    }

    return null;
  }

  LevelModel? _buildCandidate({
    required int levelId,
    required int worldId,
    required int indexInWorld,
    required WorldTemplate template,
    required GeneratedObjectiveKind objectiveKind,
    required Random rng,
  }) {
    final size = template.boardSize;
    final goalRow = size - 1;
    final goalCol = size - 1;
    final numberCount = numberTileCountForLevel(template, indexInWorld);

    final occupied = <String>{'$goalRow,$goalCol'};
    final tiles = <TileModel>[
      TileModel(
        id: 'g1',
        type: TileType.goal,
        row: goalRow,
        col: goalCol,
        isLocked: true,
      ),
    ];

    final positions = _randomEmptyCells(
      size: size,
      count: numberCount,
      occupied: occupied,
      rng: rng,
      avoidCorners: true,
    );

    for (var i = 0; i < numberCount; i++) {
      final pos = positions[i];
      final value = _numberValue(
        template: template,
        index: i,
        indexInWorld: indexInWorld,
        rng: rng,
      );
      tiles.add(
        TileModel(
          id: 't${i + 1}',
          type: TileType.number,
          value: value,
          row: pos.$1,
          col: pos.$2,
        ),
      );
    }

    _addSpecialTiles(
      tiles: tiles,
      template: template,
      size: size,
      indexInWorld: indexInWorld,
      occupied: occupied,
      rng: rng,
    );

    final objective = _objectiveFor(
      objectiveKind: objectiveKind,
      goalRow: goalRow,
      goalCol: goalCol,
      tiles: tiles,
    );

    return LevelModel(
      id: levelId,
      world: worldId,
      tier: template.tier,
      board: BoardModel(rows: size, cols: size, tiles: tiles),
      objective: objective,
      minimumMoves: 1,
    );
  }

  void _addSpecialTiles({
    required List<TileModel> tiles,
    required WorldTemplate template,
    required int size,
    required int indexInWorld,
    required Set<String> occupied,
    required Random rng,
  }) {
    final exclusive = template.worldId >= 8;
    final pick = exclusive ? indexInWorld % 4 : -1;

    if (template.allowWalls &&
        indexInWorld.isEven &&
        (!exclusive || pick == 0)) {
      final wallPos = _randomEmptyCells(
        size: size,
        count: 1,
        occupied: occupied,
        rng: rng,
      );
      if (wallPos.isEmpty) {
        return;
      }
      tiles.add(
        TileModel(
          id: 'w1',
          type: TileType.wall,
          row: wallPos.first.$1,
          col: wallPos.first.$2,
          isLocked: true,
        ),
      );
      if (exclusive) {
        return;
      }
    }

    if (template.allowPortals &&
        indexInWorld % 3 == 0 &&
        (!exclusive || pick == 1)) {
      final portalCells = _randomEmptyCells(
        size: size,
        count: 2,
        occupied: occupied,
        rng: rng,
      );
      if (portalCells.length < 2) {
        return;
      }
      tiles.addAll([
        TileModel(
          id: 'p1',
          type: TileType.portal,
          row: portalCells[0].$1,
          col: portalCells[0].$2,
          isLocked: true,
          portalPairId: 'p2',
        ),
        TileModel(
          id: 'p2',
          type: TileType.portal,
          row: portalCells[1].$1,
          col: portalCells[1].$2,
          isLocked: true,
          portalPairId: 'p1',
        ),
      ]);
      if (exclusive) {
        return;
      }
    }

    if (template.allowModifiers &&
        indexInWorld % 4 == 1 &&
        (!exclusive || pick == 2)) {
      final modPos = _randomEmptyCells(
        size: size,
        count: 1,
        occupied: occupied,
        rng: rng,
      );
      if (modPos.isEmpty) {
        return;
      }
      final modType = modifierTypeForIndex(indexInWorld);
      tiles.add(
        TileModel(
          id: 'm1',
          type: modType,
          row: modPos.first.$1,
          col: modPos.first.$2,
          isLocked: true,
          modifierFactor: modType == TileType.inverter ? 1 : 2,
        ),
      );
      if (exclusive) {
        return;
      }
    }

    if (template.allowMechanisms &&
        indexInWorld % 7 == 4 &&
        template.worldId == 7) {
      final freezePos = _randomEmptyCells(
        size: size,
        count: 1,
        occupied: occupied,
        rng: rng,
      );
      if (freezePos.isEmpty) {
        return;
      }
      tiles.add(
        TileModel(
          id: 'f1',
          type: TileType.freeze,
          value: 3 + (indexInWorld % 3),
          row: freezePos.first.$1,
          col: freezePos.first.$2,
          isLocked: true,
        ),
      );
    }

    if (template.allowMechanisms &&
        indexInWorld % 5 == 2 &&
        (!exclusive || pick == 3)) {
      final switchCells = _randomEmptyCells(
        size: size,
        count: 1,
        occupied: occupied,
        rng: rng,
      );
      if (switchCells.isEmpty) {
        return;
      }
      final switchPos = switchCells.first;
      final doorCells = _randomEmptyCells(
        size: size,
        count: 1,
        occupied: occupied,
        rng: rng,
      );
      if (doorCells.isEmpty || doorCells.first == switchPos) {
        return;
      }
      final doorPos = doorCells.first;
      tiles.addAll([
        TileModel(
          id: 's1',
          type: TileType.switchTile,
          row: switchPos.$1,
          col: switchPos.$2,
          isLocked: true,
          switchId: 'sw1',
        ),
        TileModel(
          id: 'dr1',
          type: TileType.door,
          row: doorPos.$1,
          col: doorPos.$2,
          isLocked: true,
          doorId: 'sw1',
        ),
      ]);
    }
  }

  ObjectiveModel _objectiveFor({
    required GeneratedObjectiveKind objectiveKind,
    required int goalRow,
    required int goalCol,
    required List<TileModel> tiles,
  }) {
    final numberTiles =
        tiles.where((tile) => tile.type == TileType.number).toList();
    if (numberTiles.isEmpty) {
      return ObjectiveModel.position(
        tileId: 't1',
        goalRow: goalRow,
        goalCol: goalCol,
      );
    }

    return buildObjective(
      kind: objectiveKind,
      goalRow: goalRow,
      goalCol: goalCol,
      numberTiles: numberTiles,
    );
  }

  int _maxSolutionMoves(WorldTemplate template, int indexInWorld) {
    if (template.worldId == 1 && indexInWorld < 5) {
      return 3;
    }
    return template.maxSolutionMoves;
  }

  int _numberValue({
    required WorldTemplate template,
    required int index,
    required int indexInWorld,
    required Random rng,
  }) {
    if (template.allowNegative && index.isOdd) {
      return -(2 + rng.nextInt(4));
    }
    return 2 + ((indexInWorld + index) % 5);
  }

  List<(int, int)> _randomEmptyCells({
    required int size,
    required int count,
    required Set<String> occupied,
    required Random rng,
    bool avoidCorners = false,
  }) {
    final candidates = <(int, int)>[];
    for (var row = 0; row < size; row++) {
      for (var col = 0; col < size; col++) {
        if (avoidCorners &&
            ((row == 0 || row == size - 1) && (col == 0 || col == size - 1))) {
          continue;
        }
        final key = '$row,$col';
        if (!occupied.contains(key)) {
          candidates.add((row, col));
        }
      }
    }
    candidates.shuffle(rng);
    final picked = candidates.take(count).toList();
    for (final cell in picked) {
      occupied.add('${cell.$1},${cell.$2}');
    }
    return picked;
  }

  Map<String, dynamic> _toLevelJson(LevelModel level, String analyzedTier) {
    return {
      'id': level.id,
      'world': level.world,
      'tier': analyzedTier,
      'rows': level.board.rows,
      'cols': level.board.cols,
      'objective': _objectiveToJson(level.objective),
      'tiles': level.board.tiles.map(_tileToJson).toList(),
      'minimumMoves': level.minimumMoves,
      'solutionMoves': level.solutionMoves,
    };
  }

  Map<String, dynamic> _objectiveToJson(ObjectiveModel objective) {
    return objective.when(
      position: (tileId, goalRow, goalCol) => {
        'type': 'position',
        'tileId': tileId,
        'goalRow': goalRow,
        'goalCol': goalCol,
      },
      sequence: (tileIds, targetValues) => {
        'type': 'sequence',
        'tileIds': tileIds,
        'targetValues': targetValues,
      },
      sum: (tileIds, targetSum) => {
        'type': 'sum',
        'tileIds': tileIds,
        'targetSum': targetSum,
      },
      balance: (regionTileIds, targetValue) => {
        'type': 'balance',
        'regionTileIds': regionTileIds,
        'targetValue': targetValue,
      },
      collection: (tileGoals) => {
        'type': 'collection',
        'tileGoals': tileGoals,
      },
      chain: (subObjectiveIds) => {
        'type': 'chain',
        'subObjectiveIds': subObjectiveIds,
      },
    );
  }

  Map<String, dynamic> _tileToJson(TileModel tile) {
    final json = <String, dynamic>{
      'id': tile.id,
      'type': _tileTypeJson(tile.type),
      'value': tile.value,
      'row': tile.row,
      'col': tile.col,
      'isLocked': tile.isLocked,
    };
    if (tile.portalPairId != null) {
      json['portalPairId'] = tile.portalPairId;
    }
    if (tile.switchId != null) {
      json['switchId'] = tile.switchId;
    }
    if (tile.doorId != null) {
      json['doorId'] = tile.doorId;
    }
    if (tile.isDoorOpen) {
      json['isDoorOpen'] = true;
    }
    if (tile.modifierFactor != 1) {
      json['modifierFactor'] = tile.modifierFactor;
    }
    return json;
  }

  String _tileTypeJson(TileType type) {
    return switch (type) {
      TileType.switchTile => 'switchTile',
      _ => type.name,
    };
  }
}
