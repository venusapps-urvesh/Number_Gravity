import '../models/level/level_model.dart';

abstract class LevelRepository {
  Future<LevelModel> loadLevel(int levelId);

  Future<List<LevelModel>> loadWorld(int worldId);

  Future<List<int>> getAllLevelIds();
}
