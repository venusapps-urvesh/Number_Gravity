import 'package:hive/hive.dart';

class StatisticsData extends HiveObject {
  StatisticsData({
    this.totalMoves = 0,
    this.levelsStarted = 0,
    this.levelsCompleted = 0,
    this.hintsUsed = 0,
    this.undosUsed = 0,
    this.totalPlayTimeSeconds = 0,
  });

  int totalMoves;
  int levelsStarted;
  int levelsCompleted;
  int hintsUsed;
  int undosUsed;
  int totalPlayTimeSeconds;
}
