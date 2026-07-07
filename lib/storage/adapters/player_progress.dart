import 'package:hive/hive.dart';

import '../../core/constants/game_constants.dart';
import 'level_progress.dart';

class PlayerProgress extends HiveObject {
  PlayerProgress({
    this.coins = startingCoins,
    this.gameplayEarnedCoins = 0,
    this.unlockedWorlds = const [1],
    this.levelProgress = const {},
    this.dailyStreak = 0,
  });

  int coins;
  int gameplayEarnedCoins;
  List<int> unlockedWorlds;
  Map<int, LevelProgress> levelProgress;
  int dailyStreak;
}
