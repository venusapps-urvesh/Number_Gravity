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
}
