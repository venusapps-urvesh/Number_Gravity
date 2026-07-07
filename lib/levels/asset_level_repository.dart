import '../core/constants/game_constants.dart';
import '../core/errors/app_exception.dart';
import '../models/level/level_model.dart';
import 'level_loader.dart';
import 'level_repository.dart';

class AssetLevelRepository implements LevelRepository {
  AssetLevelRepository({LevelLoader? loader})
    : _loader = loader ?? LevelLoader();

  final LevelLoader _loader;
  final Map<int, LevelModel> _cache = {};

  String _worldAssetPath(int worldId) {
    final padded = worldId.toString().padLeft(2, '0');
    return 'assets/levels/world_$padded.json';
  }

  @override
  Future<List<int>> getAllLevelIds() async {
    final ids = <int>[];
    for (var world = 1; world <= totalWorlds; world++) {
      try {
        final levels = await loadWorld(world);
        ids.addAll(levels.map((level) => level.id));
      } on LevelLoadException {
        continue;
      }
    }
    return ids;
  }

  @override
  Future<LevelModel> loadLevel(int levelId) async {
    if (_cache.containsKey(levelId)) {
      return _cache[levelId]!;
    }

    final worldId = ((levelId - 1) ~/ levelsPerWorld) + 1;
    final levels = await loadWorld(worldId);
    for (final level in levels) {
      _cache[level.id] = level;
    }

    final level = _cache[levelId];
    if (level == null) {
      throw LevelLoadException('Level not found: $levelId');
    }
    return level;
  }

  @override
  Future<List<LevelModel>> loadWorld(int worldId) async {
    final levels = await _loader.loadWorldFromAsset(_worldAssetPath(worldId));
    final resolvedLevels = await Future.wait(
      levels.map((level) async {
        final solutionMoves = await _loader.loadSolutionMovesForLevel(level.id);
        return level.copyWith(solutionMoves: solutionMoves);
      }),
    );
    for (final level in resolvedLevels) {
      _cache[level.id] = level;
    }
    return resolvedLevels;
  }
}
