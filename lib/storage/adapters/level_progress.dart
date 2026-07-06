import 'package:hive/hive.dart';

class LevelProgress extends HiveObject {
  LevelProgress({
    required this.levelId,
    this.stars = 0,
    this.isCompleted = false,
    this.bestMoves,
  });

  int levelId;
  int stars;
  bool isCompleted;
  int? bestMoves;
}
