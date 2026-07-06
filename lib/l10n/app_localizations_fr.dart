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
}
