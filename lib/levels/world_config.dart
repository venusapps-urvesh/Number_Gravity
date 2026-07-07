import '../core/constants/game_constants.dart';
import '../storage/adapters/player_progress.dart';

class WorldConfig {
  const WorldConfig({
    required this.id,
    required this.name,
    required this.mechanic,
    required this.boardSize,
    required this.startLevel,
    required this.endLevel,
  });

  final int id;
  final String name;
  final String mechanic;
  final int boardSize;
  final int startLevel;
  final int endLevel;
}

const List<WorldConfig> worldConfigs = [
  WorldConfig(
    id: 1,
    name: 'First Pull',
    mechanic: 'Attraction only',
    boardSize: 4,
    startLevel: 1,
    endLevel: 25,
  ),
  WorldConfig(
    id: 2,
    name: 'Push Back',
    mechanic: 'Repulsion',
    boardSize: 5,
    startLevel: 26,
    endLevel: 50,
  ),
  WorldConfig(
    id: 3,
    name: 'Obstacles',
    mechanic: 'Walls',
    boardSize: 5,
    startLevel: 51,
    endLevel: 75,
  ),
  WorldConfig(
    id: 4,
    name: 'Collisions',
    mechanic: 'Collisions',
    boardSize: 6,
    startLevel: 76,
    endLevel: 100,
  ),
  WorldConfig(
    id: 5,
    name: 'Portals',
    mechanic: 'Portals',
    boardSize: 6,
    startLevel: 101,
    endLevel: 125,
  ),
  WorldConfig(
    id: 6,
    name: 'Transformers',
    mechanic: 'Modifiers',
    boardSize: 7,
    startLevel: 126,
    endLevel: 150,
  ),
  WorldConfig(
    id: 7,
    name: 'Mechanisms',
    mechanic: 'Switches & doors',
    boardSize: 7,
    startLevel: 151,
    endLevel: 175,
  ),
  WorldConfig(
    id: 8,
    name: 'Mastery',
    mechanic: 'Mixed',
    boardSize: 8,
    startLevel: 176,
    endLevel: totalLaunchLevels,
  ),
];

WorldConfig? worldForLevel(int levelId) {
  for (final world in worldConfigs) {
    if (levelId >= world.startLevel && levelId <= world.endLevel) {
      return world;
    }
  }
  return null;
}

bool isLevelUnlocked(PlayerProgress progress, int levelId) {
  if (levelId <= 1) {
    return true;
  }
  return progress.levelProgress[levelId - 1]?.isCompleted ?? false;
}
