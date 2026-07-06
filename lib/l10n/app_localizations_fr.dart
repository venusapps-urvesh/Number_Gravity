// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Number Gravity';

  @override
  String get loading => 'Chargement...';

  @override
  String get homeTitle => 'Number Gravity';

  @override
  String get homeSubtitle => 'Prévoir. Planifier. Résoudre.';

  @override
  String get playCampaign => 'Campagne';

  @override
  String get playLevel => 'Jouer niveau 1';

  @override
  String get settings => 'Paramètres';

  @override
  String get dailyPuzzle => 'Puzzle du jour';

  @override
  String get leaderboard => 'Classement';

  @override
  String get worlds => 'Mondes';

  @override
  String get selectWorld => 'Choisir un monde';

  @override
  String get shop => 'Boutique';

  @override
  String get achievements => 'Succès';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get gameplayPlaceholder => 'Le plateau sera rendu en phase 3';

  @override
  String get themeMode => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get colorBlindMode => 'Mode daltonien';

  @override
  String get reduceMotion => 'Réduire les animations';

  @override
  String get accessibility => 'Accessibilité';

  @override
  String get appearance => 'Apparence';

  @override
  String get undo => 'Annuler';

  @override
  String get redo => 'Rétablir';

  @override
  String get hint => 'Indice';

  @override
  String get restart => 'Recommencer';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get swipeToMove => 'Glissez pour déplacer';

  @override
  String levelTitle(int id) {
    return 'Niveau $id';
  }

  @override
  String movesOptimal(int used, int optimal) {
    return '$used/$optimal optimal';
  }

  @override
  String get levelComplete => 'Niveau terminé';

  @override
  String get moves => 'Coups';

  @override
  String optimalLabel(int count) {
    return 'Optimal : $count';
  }

  @override
  String get coinsEarned => 'Pièces gagnées';

  @override
  String get shareSolution => 'Partagez votre solution';

  @override
  String get nextLevel => 'Niveau suivant';

  @override
  String get replay => 'Rejouer';

  @override
  String get home => 'Accueil';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get doubleCoins => 'Doublez vos pièces !';

  @override
  String watchAdCoins(int amount) {
    return 'Regardez une pub pour gagner +$amount';
  }

  @override
  String get levels => 'Niveaux';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get shareApp => 'Partager';

  @override
  String get shareAppMessage =>
      'Essayez Number Gravity ! Prévoir. Planifier. Résoudre.';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get profile => 'Profil';

  @override
  String get statLevels => 'Niveaux';

  @override
  String get statStars => 'Étoiles';

  @override
  String get statEarnedCoins => 'Gagnées';

  @override
  String get worldProgress => 'Progression des mondes';

  @override
  String dayStreak(int count) {
    return 'Série de $count jours';
  }

  @override
  String get totalMovesLabel => 'Coups au total';

  @override
  String get hintsUsedLabel => 'Indices utilisés';

  @override
  String get coinsEarnedTab => 'Pièces gagnées';

  @override
  String get skillLadderTab => 'Échelle de talent';

  @override
  String get scopeGlobal => 'Global';

  @override
  String get scopeWeekly => 'Hebdo';

  @override
  String get scopeFriends => 'Amis';

  @override
  String get you => 'Vous';

  @override
  String get leaderboardFairness =>
      'Classe uniquement les pièces gagnées en jouant — pièces achetées et de pubs exclues. Le rang ne s\'achète pas.';

  @override
  String get leaderboardEmpty =>
      'Pas encore de classement. Jouez pour gagner votre place.';

  @override
  String get starterPack => 'Pack de départ';

  @override
  String get starterPackDesc => 'Pièces + un thème · une fois';

  @override
  String get packPouch => 'Bourse';

  @override
  String get packBag => 'Sac';

  @override
  String get packChest => 'Coffre';

  @override
  String get packVault => 'Chambre forte';

  @override
  String bonusPercent(int percent) {
    return '+$percent%';
  }

  @override
  String coinCount(int count) {
    return '$count pièces';
  }

  @override
  String get bestValue => 'Meilleure offre';

  @override
  String get watchAnAd => 'Regarder une pub';

  @override
  String adRewardAmount(int amount) {
    return '+$amount';
  }

  @override
  String get adsOptIn => 'Les pubs sont facultatives — jamais imposées.';

  @override
  String get claim => 'Récupérer';

  @override
  String get claimed => 'Récupéré';

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total';
  }

  @override
  String get achFirstWorldTitle => 'Conquérant de Mondes';

  @override
  String get achFirstWorldDesc => 'Terminez le Monde 1';

  @override
  String get achPerfectTitle => 'Perfectionniste';

  @override
  String get achPerfectDesc => 'Obtenez 3 étoiles sur 10 niveaux';

  @override
  String get achStreakTitle => 'Guerrier de la Semaine';

  @override
  String get achStreakDesc => 'Atteignez une série de 7 jours';

  @override
  String get achNoHintTitle => 'Héros Sans Indice';

  @override
  String get achNoHintDesc => 'Réussissez 25 niveaux sans indice';

  @override
  String get achSpeedTitle => 'Solveur Rapide';

  @override
  String get achSpeedDesc => 'Résolvez 30 niveaux de façon optimale';

  @override
  String get achDailyTitle => 'Fidèle du Quotidien';

  @override
  String get achDailyDesc => 'Terminez 30 puzzles quotidiens';

  @override
  String dailySeed(String date) {
    return 'Graine · $date · même plateau partout';
  }

  @override
  String get solveTodaysPuzzle => 'Résoudre le puzzle du jour';

  @override
  String get skillLadderNote =>
      'Le moins de coups vous classe sur l\'échelle de talent inachetable';

  @override
  String get streak => 'Série';

  @override
  String get tutorial => 'Tutoriel';

  @override
  String get tutorialTitle1 => 'Les tuiles bleues attirent.';

  @override
  String get tutorialBody1 =>
      'Les nombres positifs attirent les tuiles proches. Glissez +3 vers l\'étoile.';

  @override
  String get tutorialTitle2 => 'Les tuiles rouges repoussent.';

  @override
  String get tutorialBody2 =>
      'Les nombres négatifs repoussent. Utilisez-les pour dévier les tuiles.';

  @override
  String get tutorialTitle3 => 'Planifiez chaque coup.';

  @override
  String get tutorialBody3 =>
      'Les aperçus montrent où la gravité se stabilise avant de valider.';

  @override
  String tutorialStep(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get startPlaying => 'Commencer le Niveau 1';

  @override
  String get next => 'Suivant';

  @override
  String get skip => 'Passer';

  @override
  String get zenMode => 'Mode Zen';

  @override
  String get zenSubtitle => 'Sans étoiles · sans minuteur · sans échec';

  @override
  String get zenBody =>
      'Détendez-vous et expérimentez. Résolvez à votre rythme.';

  @override
  String get startZen => 'Lancer un plateau Zen';
}
