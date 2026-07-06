// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
}
