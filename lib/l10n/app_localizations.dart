import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Number Gravity'**
  String get appName;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Number Gravity'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Predict. Plan. Solve.'**
  String get homeSubtitle;

  /// No description provided for @playCampaign.
  ///
  /// In en, this message translates to:
  /// **'Play Campaign'**
  String get playCampaign;

  /// No description provided for @playLevel.
  ///
  /// In en, this message translates to:
  /// **'Play Level 1'**
  String get playLevel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dailyPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Daily Puzzle'**
  String get dailyPuzzle;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @worlds.
  ///
  /// In en, this message translates to:
  /// **'Worlds'**
  String get worlds;

  /// No description provided for @selectWorld.
  ///
  /// In en, this message translates to:
  /// **'Select World'**
  String get selectWorld;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming in a future phase'**
  String get comingSoon;

  /// No description provided for @gameplayPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Game board renders in Phase 3'**
  String get gameplayPlaceholder;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @colorBlindMode.
  ///
  /// In en, this message translates to:
  /// **'Color-blind mode'**
  String get colorBlindMode;

  /// No description provided for @reduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reduceMotion;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @swipeToMove.
  ///
  /// In en, this message translates to:
  /// **'Swipe to move'**
  String get swipeToMove;

  /// No description provided for @levelTitle.
  ///
  /// In en, this message translates to:
  /// **'Level {id}'**
  String levelTitle(int id);

  /// No description provided for @movesOptimal.
  ///
  /// In en, this message translates to:
  /// **'{used}/{optimal} Optimal'**
  String movesOptimal(int used, int optimal);

  /// No description provided for @levelComplete.
  ///
  /// In en, this message translates to:
  /// **'Level Complete'**
  String get levelComplete;

  /// No description provided for @moves.
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get moves;

  /// No description provided for @optimalLabel.
  ///
  /// In en, this message translates to:
  /// **'Optimal: {count}'**
  String optimalLabel(int count);

  /// No description provided for @coinsEarned.
  ///
  /// In en, this message translates to:
  /// **'Coins Earned'**
  String get coinsEarned;

  /// No description provided for @shareSolution.
  ///
  /// In en, this message translates to:
  /// **'Share your solution'**
  String get shareSolution;

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get nextLevel;

  /// No description provided for @replay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replay;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @doubleCoins.
  ///
  /// In en, this message translates to:
  /// **'Double Your Coins!'**
  String get doubleCoins;

  /// No description provided for @watchAdCoins.
  ///
  /// In en, this message translates to:
  /// **'Watch an ad to earn +{amount}'**
  String watchAdCoins(int amount);

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareApp;

  /// No description provided for @shareAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Try Number Gravity! Predict. Plan. Solve.'**
  String get shareAppMessage;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @statLevels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get statLevels;

  /// No description provided for @statStars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get statStars;

  /// No description provided for @statEarnedCoins.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get statEarnedCoins;

  /// No description provided for @worldProgress.
  ///
  /// In en, this message translates to:
  /// **'World progress'**
  String get worldProgress;

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String dayStreak(int count);

  /// No description provided for @totalMovesLabel.
  ///
  /// In en, this message translates to:
  /// **'Total moves'**
  String get totalMovesLabel;

  /// No description provided for @hintsUsedLabel.
  ///
  /// In en, this message translates to:
  /// **'Hints used'**
  String get hintsUsedLabel;

  /// No description provided for @coinsEarnedTab.
  ///
  /// In en, this message translates to:
  /// **'Coins earned'**
  String get coinsEarnedTab;

  /// No description provided for @skillLadderTab.
  ///
  /// In en, this message translates to:
  /// **'Skill ladder'**
  String get skillLadderTab;

  /// No description provided for @scopeGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get scopeGlobal;

  /// No description provided for @scopeWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get scopeWeekly;

  /// No description provided for @scopeFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get scopeFriends;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @leaderboardFairness.
  ///
  /// In en, this message translates to:
  /// **'Ranks gameplay-earned coins only — purchased and ad coins excluded. Rank can\'t be bought.'**
  String get leaderboardFairness;

  /// No description provided for @leaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No rankings yet. Play levels to earn your place.'**
  String get leaderboardEmpty;

  /// No description provided for @starterPack.
  ///
  /// In en, this message translates to:
  /// **'Starter Pack'**
  String get starterPack;

  /// No description provided for @starterPackDesc.
  ///
  /// In en, this message translates to:
  /// **'Coins + a theme · one time'**
  String get starterPackDesc;

  /// No description provided for @packPouch.
  ///
  /// In en, this message translates to:
  /// **'Pouch'**
  String get packPouch;

  /// No description provided for @packBag.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get packBag;

  /// No description provided for @packChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get packChest;

  /// No description provided for @packVault.
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get packVault;

  /// No description provided for @bonusPercent.
  ///
  /// In en, this message translates to:
  /// **'+{percent}%'**
  String bonusPercent(int percent);

  /// No description provided for @coinCount.
  ///
  /// In en, this message translates to:
  /// **'{count} coins'**
  String coinCount(int count);

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get bestValue;

  /// No description provided for @watchAnAd.
  ///
  /// In en, this message translates to:
  /// **'Watch an ad'**
  String get watchAnAd;

  /// No description provided for @adRewardAmount.
  ///
  /// In en, this message translates to:
  /// **'+{amount}'**
  String adRewardAmount(int amount);

  /// No description provided for @adsOptIn.
  ///
  /// In en, this message translates to:
  /// **'Ads are opt-in only — never forced.'**
  String get adsOptIn;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @claimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed'**
  String get claimed;

  /// No description provided for @achievementsCount.
  ///
  /// In en, this message translates to:
  /// **'{unlocked}/{total}'**
  String achievementsCount(int unlocked, int total);

  /// No description provided for @achFirstWorldTitle.
  ///
  /// In en, this message translates to:
  /// **'World Conqueror'**
  String get achFirstWorldTitle;

  /// No description provided for @achFirstWorldDesc.
  ///
  /// In en, this message translates to:
  /// **'Finish World 1'**
  String get achFirstWorldDesc;

  /// No description provided for @achPerfectTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfectionist'**
  String get achPerfectTitle;

  /// No description provided for @achPerfectDesc.
  ///
  /// In en, this message translates to:
  /// **'Earn 3 stars on 10 levels'**
  String get achPerfectDesc;

  /// No description provided for @achStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Week Warrior'**
  String get achStreakTitle;

  /// No description provided for @achStreakDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 7-day streak'**
  String get achStreakDesc;

  /// No description provided for @achNoHintTitle.
  ///
  /// In en, this message translates to:
  /// **'No-Hint Hero'**
  String get achNoHintTitle;

  /// No description provided for @achNoHintDesc.
  ///
  /// In en, this message translates to:
  /// **'Clear 25 levels with no hints'**
  String get achNoHintDesc;

  /// No description provided for @achSpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Speed Solver'**
  String get achSpeedTitle;

  /// No description provided for @achSpeedDesc.
  ///
  /// In en, this message translates to:
  /// **'Solve 30 levels optimally'**
  String get achSpeedDesc;

  /// No description provided for @achDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Devotee'**
  String get achDailyTitle;

  /// No description provided for @achDailyDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 30 daily puzzles'**
  String get achDailyDesc;

  /// No description provided for @dailySeed.
  ///
  /// In en, this message translates to:
  /// **'Seed · {date} · same board worldwide'**
  String dailySeed(String date);

  /// No description provided for @solveTodaysPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Solve today\'s puzzle'**
  String get solveTodaysPuzzle;

  /// No description provided for @skillLadderNote.
  ///
  /// In en, this message translates to:
  /// **'Fewest moves ranks you on the unbuyable skill ladder'**
  String get skillLadderNote;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @tutorialTitle1.
  ///
  /// In en, this message translates to:
  /// **'Blue tiles pull.'**
  String get tutorialTitle1;

  /// No description provided for @tutorialBody1.
  ///
  /// In en, this message translates to:
  /// **'Positive numbers attract nearby tiles. Slide +3 toward the star.'**
  String get tutorialBody1;

  /// No description provided for @tutorialTitle2.
  ///
  /// In en, this message translates to:
  /// **'Red tiles push.'**
  String get tutorialTitle2;

  /// No description provided for @tutorialBody2.
  ///
  /// In en, this message translates to:
  /// **'Negative numbers repel. Use them to steer tiles away.'**
  String get tutorialBody2;

  /// No description provided for @tutorialTitle3.
  ///
  /// In en, this message translates to:
  /// **'Plan every move.'**
  String get tutorialTitle3;

  /// No description provided for @tutorialBody3.
  ///
  /// In en, this message translates to:
  /// **'Ghost previews show where gravity settles before you commit.'**
  String get tutorialBody3;

  /// No description provided for @tutorialStep.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String tutorialStep(int current, int total);

  /// No description provided for @startPlaying.
  ///
  /// In en, this message translates to:
  /// **'Start Level 1'**
  String get startPlaying;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @zenMode.
  ///
  /// In en, this message translates to:
  /// **'Zen Mode'**
  String get zenMode;

  /// No description provided for @zenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No stars · no timer · no fail state'**
  String get zenSubtitle;

  /// No description provided for @zenBody.
  ///
  /// In en, this message translates to:
  /// **'Relax and experiment. Solve at your own pace.'**
  String get zenBody;

  /// No description provided for @startZen.
  ///
  /// In en, this message translates to:
  /// **'Start a Zen board'**
  String get startZen;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How to Play'**
  String get howToPlay;

  /// No description provided for @howToPlayIntro.
  ///
  /// In en, this message translates to:
  /// **'Number Gravity is a puzzle where numbered tiles attract and repel each other. Plan your moves, let gravity settle, and reach the goal in as few moves as possible.'**
  String get howToPlayIntro;

  /// No description provided for @howToPlayGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Reach the goal'**
  String get howToPlayGoalTitle;

  /// No description provided for @howToPlayGoalBody.
  ///
  /// In en, this message translates to:
  /// **'Every level has an objective — usually landing a tile on the golden star. Read the level goal, then plan a path through the grid.'**
  String get howToPlayGoalBody;

  /// No description provided for @howToPlayPullTitle.
  ///
  /// In en, this message translates to:
  /// **'Blue tiles pull'**
  String get howToPlayPullTitle;

  /// No description provided for @howToPlayPullBody.
  ///
  /// In en, this message translates to:
  /// **'Positive numbers attract nearby tiles. A +3 tile pulls others toward it. Use attraction to steer tiles where you need them.'**
  String get howToPlayPullBody;

  /// No description provided for @howToPlayPushTitle.
  ///
  /// In en, this message translates to:
  /// **'Red tiles push'**
  String get howToPlayPushTitle;

  /// No description provided for @howToPlayPushBody.
  ///
  /// In en, this message translates to:
  /// **'Negative numbers repel nearby tiles. A −2 tile pushes others away. Combine push and pull to solve tricky layouts.'**
  String get howToPlayPushBody;

  /// No description provided for @howToPlaySwipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe to move'**
  String get howToPlaySwipeTitle;

  /// No description provided for @howToPlaySwipeBody.
  ///
  /// In en, this message translates to:
  /// **'Tap a tile to select it, then swipe up, down, left, or right to move it one cell. You can also swipe without selecting — the main tile moves.'**
  String get howToPlaySwipeBody;

  /// No description provided for @howToPlayGravityTitle.
  ///
  /// In en, this message translates to:
  /// **'Gravity settles automatically'**
  String get howToPlayGravityTitle;

  /// No description provided for @howToPlayGravityBody.
  ///
  /// In en, this message translates to:
  /// **'After each move, gravity runs until the board is stable. Tiles keep sliding based on forces until nothing moves. Watch the chain reaction before your next turn.'**
  String get howToPlayGravityBody;

  /// No description provided for @howToPlayStarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Earn stars'**
  String get howToPlayStarsTitle;

  /// No description provided for @howToPlayStarsBody.
  ///
  /// In en, this message translates to:
  /// **'Finish in the minimum moves for 3 stars. Up to two extra moves still earns 2 stars. Fewer moves mean more coins and better rankings.'**
  String get howToPlayStarsBody;

  /// No description provided for @howToPlayControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Undo & Hint'**
  String get howToPlayControlsTitle;

  /// No description provided for @howToPlayControlsBody.
  ///
  /// In en, this message translates to:
  /// **'Made a mistake? Tap Undo to rewind one move. Stuck? Use Hint to see a suggested direction. Hints are limited — use them wisely.'**
  String get howToPlayControlsBody;

  /// No description provided for @howToPlayStart.
  ///
  /// In en, this message translates to:
  /// **'Start Level 1'**
  String get howToPlayStart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
