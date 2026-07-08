import '../../levels/world_config.dart';
import '../../models/level/level_tier.dart';
import '../../models/objective/objective_model.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

/// Objective kinds generated per world (production doc §4, §7).
enum GeneratedObjectiveKind {
  position,
  sum,
  balance,
  collection,
  sequence,
  chain,
}

GeneratedObjectiveKind objectiveKindForLevel(int worldId, int indexInWorld) {
  return switch (worldId) {
    1 || 2 || 3 => GeneratedObjectiveKind.position,
    4 => indexInWorld % 3 == 2
        ? GeneratedObjectiveKind.sum
        : GeneratedObjectiveKind.position,
    5 => indexInWorld.isOdd
        ? GeneratedObjectiveKind.collection
        : GeneratedObjectiveKind.position,
    6 => indexInWorld.isOdd
        ? GeneratedObjectiveKind.balance
        : GeneratedObjectiveKind.sum,
    7 => indexInWorld.isOdd
        ? GeneratedObjectiveKind.sequence
        : GeneratedObjectiveKind.collection,
    8 => indexInWorld >= 22
        ? GeneratedObjectiveKind.chain
        : switch (indexInWorld % 5) {
            1 => GeneratedObjectiveKind.collection,
            2 => GeneratedObjectiveKind.sum,
            3 => GeneratedObjectiveKind.balance,
            4 => GeneratedObjectiveKind.sequence,
            _ => GeneratedObjectiveKind.position,
          },
    _ => GeneratedObjectiveKind.position,
  };
}

ObjectiveModel buildObjective({
  required GeneratedObjectiveKind kind,
  required int goalRow,
  required int goalCol,
  required List<TileModel> numberTiles,
}) {
  final ids = numberTiles.map((t) => t.id).toList();
  final values = numberTiles.map((t) => t.value).toList();

  return switch (kind) {
    GeneratedObjectiveKind.sum => ObjectiveModel.sum(
        tileIds: ids,
        targetSum: _sumTarget(values),
      ),
    GeneratedObjectiveKind.balance => ObjectiveModel.balance(
        regionTileIds: ids,
        targetValue: _balanceTarget(values),
      ),
    GeneratedObjectiveKind.sequence => ObjectiveModel.sequence(
        tileIds: ids,
        targetValues: _sequenceTargets(values),
      ),
    GeneratedObjectiveKind.collection => ObjectiveModel.collection(
        tileGoals: {ids.first: [goalRow, goalCol]},
      ),
    GeneratedObjectiveKind.chain => ObjectiveModel.chain(
        subObjectiveIds: [ids.first],
      ),
    GeneratedObjectiveKind.position => ObjectiveModel.position(
        tileId: ids.first,
        goalRow: goalRow,
        goalCol: goalCol,
      ),
  };
}

TileType modifierTypeForIndex(int indexInWorld) {
  return switch (indexInWorld % 3) {
    1 => TileType.divider,
    2 => TileType.inverter,
    _ => TileType.multiplier,
  };
}

int _sumTarget(List<int> values) {
  final current = values.fold<int>(0, (sum, value) => sum + value);
  return current > 2 ? current - 1 : current + 2;
}

int _balanceTarget(List<int> values) {
  if (values.length > 1 && values.first != values.last) {
    return values.last;
  }
  return values.first + 1;
}

List<int> _sequenceTargets(List<int> values) {
  return values.map((value) => value + 1).toList();
}


/// Per-world generation constraints from production doc §7.
class WorldTemplate {
  const WorldTemplate({
    required this.worldId,
    required this.boardSize,
    required this.tier,
    required this.minNumberTiles,
    required this.maxNumberTiles,
    required this.allowNegative,
    required this.allowWalls,
    required this.allowPortals,
    required this.allowModifiers,
    required this.allowMechanisms,
    required this.minSolutionMoves,
    required this.maxSolutionMoves,
  });

  final int worldId;
  final int boardSize;
  final LevelTier tier;
  final int minNumberTiles;
  final int maxNumberTiles;
  final bool allowNegative;
  final bool allowWalls;
  final bool allowPortals;
  final bool allowModifiers;
  final bool allowMechanisms;
  final int minSolutionMoves;
  final int maxSolutionMoves;
}

WorldTemplate templateForWorld(int worldId) {
  final config = worldConfigs.firstWhere((w) => w.id == worldId);
  return switch (worldId) {
    1 => WorldTemplate(
        worldId: 1,
        boardSize: config.boardSize,
        tier: LevelTier.beginner,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: false,
        allowWalls: false,
        allowPortals: false,
        allowModifiers: false,
        allowMechanisms: false,
        minSolutionMoves: 2,
        maxSolutionMoves: 12,
      ),
    2 => WorldTemplate(
        worldId: 2,
        boardSize: config.boardSize,
        tier: LevelTier.beginner,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: true,
        allowWalls: false,
        allowPortals: false,
        allowModifiers: false,
        allowMechanisms: false,
        minSolutionMoves: 2,
        maxSolutionMoves: 10,
      ),
    3 => WorldTemplate(
        worldId: 3,
        boardSize: config.boardSize,
        tier: LevelTier.beginner,
        minNumberTiles: 1,
        maxNumberTiles: 2,
        allowNegative: false,
        allowWalls: true,
        allowPortals: false,
        allowModifiers: false,
        allowMechanisms: false,
        minSolutionMoves: 2,
        maxSolutionMoves: 12,
      ),
    4 => WorldTemplate(
        worldId: 4,
        boardSize: config.boardSize,
        tier: LevelTier.intermediate,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: true,
        allowWalls: true,
        allowPortals: false,
        allowModifiers: false,
        allowMechanisms: false,
        minSolutionMoves: 3,
        maxSolutionMoves: 14,
      ),
    5 => WorldTemplate(
        worldId: 5,
        boardSize: config.boardSize,
        tier: LevelTier.intermediate,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: false,
        allowWalls: true,
        allowPortals: true,
        allowModifiers: false,
        allowMechanisms: false,
        minSolutionMoves: 3,
        maxSolutionMoves: 16,
      ),
    6 => WorldTemplate(
        worldId: 6,
        boardSize: config.boardSize,
        tier: LevelTier.advanced,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: true,
        allowWalls: true,
        allowPortals: false,
        allowModifiers: true,
        allowMechanisms: false,
        minSolutionMoves: 3,
        maxSolutionMoves: 18,
      ),
    7 => WorldTemplate(
        worldId: 7,
        boardSize: config.boardSize,
        tier: LevelTier.advanced,
        minNumberTiles: 2,
        maxNumberTiles: 3,
        allowNegative: true,
        allowWalls: true,
        allowPortals: false,
        allowModifiers: true,
        allowMechanisms: true,
        minSolutionMoves: 4,
        maxSolutionMoves: 20,
      ),
    _ => WorldTemplate(
        worldId: 8,
        boardSize: config.boardSize,
        tier: LevelTier.advanced,
        minNumberTiles: 2,
        maxNumberTiles: 4,
        allowNegative: true,
        allowWalls: true,
        allowPortals: true,
        allowModifiers: true,
        allowMechanisms: true,
        minSolutionMoves: 4,
        maxSolutionMoves: 18,
      ),
  };
}

int numberTileCountForLevel(WorldTemplate template, int indexInWorld) {
  if (template.worldId == 1) {
    if (indexInWorld < 5) {
      return 2;
    }
    if (indexInWorld < 15) {
      return 2 + (indexInWorld % 2);
    }
    return 3;
  }
  return template.minNumberTiles +
      (indexInWorld % (template.maxNumberTiles - template.minNumberTiles + 1));
}

Set<TileType> specialTypesForWorld(WorldTemplate template) {
  final types = <TileType>{};
  if (template.allowWalls) {
    types.add(TileType.wall);
  }
  if (template.allowPortals) {
    types.add(TileType.portal);
  }
  if (template.allowModifiers) {
    types.addAll([
      TileType.multiplier,
      TileType.divider,
      TileType.inverter,
    ]);
  }
  if (template.allowMechanisms) {
    types.addAll([
      TileType.switchTile,
      TileType.door,
      TileType.freeze,
    ]);
  }
  return types;
}
