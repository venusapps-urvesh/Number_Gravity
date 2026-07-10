// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Number Gravity';

  @override
  String get loading => 'Loading...';

  @override
  String get homeTitle => 'Number Gravity';

  @override
  String get homeSubtitle => 'Predict. Plan. Solve.';

  @override
  String get playCampaign => 'Play Campaign';

  @override
  String get playLevel => 'Play Level 1';

  @override
  String get settings => 'Settings';

  @override
  String get dailyPuzzle => 'Daily Puzzle';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get worlds => 'Worlds';

  @override
  String get selectWorld => 'Select World';

  @override
  String get shop => 'Shop';

  @override
  String get achievements => 'Achievements';

  @override
  String get comingSoon => 'Coming in a future phase';

  @override
  String get gameplayPlaceholder => 'Game board renders in Phase 3';

  @override
  String get themeMode => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get colorBlindMode => 'Color-blind mode';

  @override
  String get reduceMotion => 'Reduce motion';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get appearance => 'Appearance';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get hint => 'Hint';

  @override
  String get restart => 'Restart';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get stuckTitle => 'No moves left';

  @override
  String get stuckBody => 'The board has no valid moves. Try undo or restart.';

  @override
  String get swipeToMove => 'Swipe to move';

  @override
  String levelTitle(int id) {
    return 'Level $id';
  }

  @override
  String movesOptimal(int used, int optimal) {
    return '$used/$optimal Optimal';
  }

  @override
  String get levelComplete => 'Level Complete';

  @override
  String get moves => 'Moves';

  @override
  String optimalLabel(int count) {
    return 'Optimal: $count';
  }

  @override
  String get coinsEarned => 'Coins Earned';

  @override
  String get shareSolution => 'Share your solution';

  @override
  String get nextLevel => 'Next Level';

  @override
  String get replay => 'Replay';

  @override
  String get home => 'Home';

  @override
  String get continueLabel => 'Continue';

  @override
  String get doubleCoins => 'Double Your Coins!';

  @override
  String watchAdCoins(int amount) {
    return 'Watch an ad to earn +$amount';
  }

  @override
  String get levels => 'Levels';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get shareApp => 'Share';

  @override
  String get shareAppMessage => 'Try Number Gravity! Predict. Plan. Solve.';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get profile => 'Profile';

  @override
  String get statLevels => 'Levels';

  @override
  String get statStars => 'Stars';

  @override
  String get statEarnedCoins => 'Earned';

  @override
  String get worldProgress => 'World progress';

  @override
  String dayStreak(int count) {
    return '$count-day streak';
  }

  @override
  String get totalMovesLabel => 'Total moves';

  @override
  String get hintsUsedLabel => 'Hints used';

  @override
  String get coinsEarnedTab => 'Coins earned';

  @override
  String get skillLadderTab => 'Skill ladder';

  @override
  String get scopeGlobal => 'Global';

  @override
  String get scopeWeekly => 'Weekly';

  @override
  String get scopeFriends => 'Friends';

  @override
  String get you => 'You';

  @override
  String get leaderboardFairness =>
      'Ranks gameplay-earned coins only — purchased and ad coins excluded. Rank can\'t be bought.';

  @override
  String get leaderboardEmpty =>
      'No rankings yet. Play levels to earn your place.';

  @override
  String get starterPack => 'Starter Pack';

  @override
  String get starterPackDesc => 'Coins + a theme · one time';

  @override
  String get packPouch => 'Pouch';

  @override
  String get packBag => 'Bag';

  @override
  String get packChest => 'Chest';

  @override
  String get packVault => 'Vault';

  @override
  String bonusPercent(int percent) {
    return '+$percent%';
  }

  @override
  String coinCount(int count) {
    return '$count coins';
  }

  @override
  String get bestValue => 'Best value';

  @override
  String get watchAnAd => 'Watch an ad';

  @override
  String adRewardAmount(int amount) {
    return '+$amount';
  }

  @override
  String get adsOptIn => 'Ads are opt-in only — never forced.';

  @override
  String get claim => 'Claim';

  @override
  String get claimed => 'Claimed';

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total';
  }

  @override
  String get achFirstWorldTitle => 'World Conqueror';

  @override
  String get achFirstWorldDesc => 'Finish World 1';

  @override
  String get achPerfectTitle => 'Perfectionist';

  @override
  String get achPerfectDesc => 'Earn 3 stars on 10 levels';

  @override
  String get achStreakTitle => 'Week Warrior';

  @override
  String get achStreakDesc => 'Reach a 7-day streak';

  @override
  String get achNoHintTitle => 'No-Hint Hero';

  @override
  String get achNoHintDesc => 'Clear 25 levels with no hints';

  @override
  String get achSpeedTitle => 'Speed Solver';

  @override
  String get achSpeedDesc => 'Solve 30 levels optimally';

  @override
  String get achDailyTitle => 'Daily Devotee';

  @override
  String get achDailyDesc => 'Complete 30 daily puzzles';

  @override
  String dailySeed(String date) {
    return 'Seed · $date · same board worldwide';
  }

  @override
  String get solveTodaysPuzzle => 'Solve today\'s puzzle';

  @override
  String get skillLadderNote =>
      'Fewest moves ranks you on the unbuyable skill ladder';

  @override
  String get streak => 'Streak';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get tutorialTitle1 => 'Blue tiles pull.';

  @override
  String get tutorialBody1 =>
      'Positive numbers attract nearby tiles. Slide +3 toward the star.';

  @override
  String get tutorialTitle2 => 'Red tiles push.';

  @override
  String get tutorialBody2 =>
      'Negative numbers repel. Use them to steer tiles away.';

  @override
  String get tutorialTitle3 => 'Plan every move.';

  @override
  String get tutorialBody3 =>
      'Ghost previews show where gravity settles before you commit.';

  @override
  String tutorialStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get startPlaying => 'Start Level 1';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get zenMode => 'Zen Mode';

  @override
  String get zenSubtitle => 'No stars · no timer · no fail state';

  @override
  String get zenBody => 'Relax and experiment. Solve at your own pace.';

  @override
  String get startZen => 'Start a Zen board';

  @override
  String get howToPlay => 'How to Play';

  @override
  String get howToPlayIntro =>
      'Number Gravity is a turn-based puzzle where numbered tiles attract and repel each other. Preview your move, let gravity settle, and reach the goal in as few moves as possible.';

  @override
  String get howToPlayGoalTitle => 'Reach the goal';

  @override
  String get howToPlayGoalBody =>
      'Every level has an objective — usually moving a tile to the gold star. Read the level goal, then plan a path through the grid.';

  @override
  String get howToPlaySelectTitle => 'Select and read forces';

  @override
  String get howToPlaySelectBody =>
      'Tap a movable tile to select it. Gold arrows show legal moves, and force lines show pull from blue + tiles and push from red − tiles.';

  @override
  String get howToPlayPreviewTitle => 'Preview then commit';

  @override
  String get howToPlayPreviewBody =>
      'Tap an arrow once to preview ghost tiles. Tap the same arrow again to commit. You can also swipe a selected tile to commit directly. After each move, gravity resolves cycle by cycle until the board settles.';

  @override
  String get howToPlayHelpersTitle => 'Use helpers';

  @override
  String get howToPlayHelpersBody =>
      'Undo gives you 1 free rewind per level, then costs coins. Redo and Hint cost coins by tier. Use them when you\'re stuck or want to try a different approach.';

  @override
  String get howToPlayStart => 'Start Level 1';

  @override
  String objectivePosition(String tileId) {
    return 'Move tile $tileId to the gold star';
  }

  @override
  String objectiveSequence(String sequence) {
    return 'Arrange tiles: $sequence';
  }

  @override
  String objectiveSum(int target) {
    return 'Make selected tiles sum to $target';
  }

  @override
  String objectiveBalance(int target) {
    return 'Balance all region tiles to $target';
  }

  @override
  String get objectiveCollection => 'Route every tile to its goal';

  @override
  String get objectiveChain => 'Land all chain tiles on goal cells';

  @override
  String worldMechanic(String mechanic) {
    return 'New mechanic: $mechanic';
  }

  @override
  String get letsPlay => 'Let\'s play';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String helperCostLabel(int cost, int balance) {
    return 'Cost: $cost coins · Balance: $balance';
  }

  @override
  String get undoCostFree => 'Free';

  @override
  String undoFreeTriesLeft(int count) {
    return '$count free';
  }

  @override
  String undoCostCoins(int cost) {
    return '$cost coins';
  }

  @override
  String get hintTier1Title => 'Which tile';

  @override
  String get hintTier1Cost => '20 coins';

  @override
  String get hintTier2Title => 'Direction';

  @override
  String get hintTier2Cost => '40 coins';

  @override
  String get hintTier3Title => 'Full move';

  @override
  String get hintTier3Cost => '80 coins';

  @override
  String get hintUnavailable => 'No hint available for this position';

  @override
  String get notEnoughCoins => 'Not enough coins';

  @override
  String get movesOverPar => 'Over par — fewer moves earn more stars';

  @override
  String get levelTip1 =>
      'Tap a blue + tile, then swipe to move it. Positive numbers pull nearby tiles.';

  @override
  String get levelTip2 =>
      'Tap an arrow once to preview gravity, then tap again to commit the move.';

  @override
  String get levelTip3 =>
      'Plan a few moves ahead — watch how tiles slide after each turn.';

  @override
  String get dailyQuestsTitle => 'Daily quests';

  @override
  String get questClearLevel => 'Clear any level';

  @override
  String get questNoHint => 'Clear a level with no hints';

  @override
  String get questDailyPuzzle => 'Play today\'s daily puzzle';

  @override
  String get questClaimed => 'Claimed';

  @override
  String questReward(int amount) {
    return '+$amount coins';
  }

  @override
  String get timeChestTitle => 'Time chest';

  @override
  String timeChestReady(int amount) {
    return 'Open for +$amount coins';
  }

  @override
  String timeChestCooldown(int hours) {
    return 'Next chest in ${hours}h';
  }

  @override
  String shareResultReward(int amount) {
    return 'Share result (+$amount coins)';
  }

  @override
  String get skipLevel => 'Skip level';

  @override
  String skipLevelCost(int cost) {
    return 'Skip for $cost coins';
  }

  @override
  String get streakFreeze => 'Streak freeze';

  @override
  String get streakFreezeDesc => 'Protect your login streak for one missed day';

  @override
  String get purchaseSuccess => 'Purchase complete';

  @override
  String adRewardGranted(int amount) {
    return '+$amount coins earned';
  }

  @override
  String get adLimitReached => 'Daily ad limit reached';
}
