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
  String get stuckTitle => 'Plus de coups';

  @override
  String get stuckBody =>
      'Le plateau n\'a plus de coups valides. Essayez d\'annuler ou de recommencer.';

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

  @override
  String get howToPlay => 'Comment jouer';

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
  String get howToPlayStart => 'Commencer le Niveau 1';

  @override
  String objectivePosition(String tileId) {
    return 'Placez la tuile $tileId sur l\'étoile dorée';
  }

  @override
  String objectiveSequence(String sequence) {
    return 'Alignez les tuiles : $sequence';
  }

  @override
  String objectiveSum(int target) {
    return 'Les tuiles doivent totaliser $target';
  }

  @override
  String objectiveBalance(int target) {
    return 'Équilibrez les tuiles de la région à $target';
  }

  @override
  String get objectiveCollection => 'Amenez chaque tuile à son objectif';

  @override
  String get objectiveChain =>
      'Placez toutes les tuiles de la chaîne sur des objectifs';

  @override
  String worldMechanic(String mechanic) {
    return 'Nouvelle mécanique : $mechanic';
  }

  @override
  String get letsPlay => 'Jouons';

  @override
  String get confirm => 'Confirmer';

  @override
  String get cancel => 'Annuler';

  @override
  String helperCostLabel(int cost, int balance) {
    return 'Coût : $cost pièces · Solde : $balance';
  }

  @override
  String get undoCostFree => 'Gratuit';

  @override
  String undoFreeTriesLeft(int count) {
    return '$count gratuit';
  }

  @override
  String undoCostCoins(int cost) {
    return '$cost pièces';
  }

  @override
  String get hintTier1Title => 'Quelle tuile';

  @override
  String get hintTier1Cost => '20 pièces';

  @override
  String get hintTier2Title => 'Direction';

  @override
  String get hintTier2Cost => '40 pièces';

  @override
  String get hintTier3Title => 'Coup complet';

  @override
  String get hintTier3Cost => '80 pièces';

  @override
  String get hintUnavailable => 'Aucun indice disponible';

  @override
  String get notEnoughCoins => 'Pièces insuffisantes';

  @override
  String get movesOverPar => 'Au-dessus du par';

  @override
  String get levelTip1 =>
      'Touchez une tuile bleue + puis glissez. Les nombres positifs attirent les tuiles proches.';

  @override
  String get levelTip2 =>
      'Touchez une flèche une fois pour prévisualiser, puis encore pour valider.';

  @override
  String get levelTip3 =>
      'Planifiez plusieurs coups — observez comment les tuiles glissent après chaque tour.';

  @override
  String get dailyQuestsTitle => 'Quêtes du jour';

  @override
  String get questClearLevel => 'Terminer un niveau';

  @override
  String get questNoHint => 'Terminer un niveau sans indice';

  @override
  String get questDailyPuzzle => 'Jouer le puzzle du jour';

  @override
  String get questClaimed => 'Réclamé';

  @override
  String questReward(int amount) {
    return '+$amount pièces';
  }

  @override
  String get timeChestTitle => 'Coffre horaire';

  @override
  String timeChestReady(int amount) {
    return 'Ouvrir pour +$amount pièces';
  }

  @override
  String timeChestCooldown(int hours) {
    return 'Prochain coffre dans ${hours}h';
  }

  @override
  String shareResultReward(int amount) {
    return 'Partager le résultat (+$amount pièces)';
  }

  @override
  String get skipLevel => 'Passer le niveau';

  @override
  String skipLevelCost(int cost) {
    return 'Passer pour $cost pièces';
  }

  @override
  String get streakFreeze => 'Gel de série';

  @override
  String get streakFreezeDesc =>
      'Protège votre série de connexion pendant un jour';

  @override
  String get purchaseSuccess => 'Achat réussi';

  @override
  String adRewardGranted(int amount) {
    return '+$amount pièces gagnées';
  }

  @override
  String get adLimitReached => 'Limite quotidienne d\'annonces atteinte';
}
