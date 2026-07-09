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
    this.lastDailyLoginDate,
    this.lastDailyPuzzleDate,
    this.questsDate,
    this.completedQuestIds = const [],
    this.rewardedAdsToday = 0,
    this.rewardedAdsDate,
    this.lastChestClaimDate,
    this.sharesToday = 0,
    this.shareDate,
    this.streakFreezes = 0,
    this.streakFreezeActive = false,
    this.dailyPuzzleBestMoves,
  });

  int coins;
  int gameplayEarnedCoins;
  List<int> unlockedWorlds;
  Map<int, LevelProgress> levelProgress;
  int dailyStreak;
  String? lastDailyLoginDate;
  String? lastDailyPuzzleDate;
  String? questsDate;
  List<String> completedQuestIds;
  int rewardedAdsToday;
  String? rewardedAdsDate;
  DateTime? lastChestClaimDate;
  int sharesToday;
  String? shareDate;
  int streakFreezes;
  bool streakFreezeActive;
  int? dailyPuzzleBestMoves;
}
