// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Number Gravity';

  @override
  String get loading => 'Cargando...';

  @override
  String get homeTitle => 'Number Gravity';

  @override
  String get homeSubtitle => 'Predice. Planifica. Resuelve.';

  @override
  String get playCampaign => 'Jugar campaña';

  @override
  String get playLevel => 'Jugar nivel 1';

  @override
  String get settings => 'Ajustes';

  @override
  String get dailyPuzzle => 'Puzzle diario';

  @override
  String get leaderboard => 'Clasificación';

  @override
  String get worlds => 'Mundos';

  @override
  String get selectWorld => 'Seleccionar mundo';

  @override
  String get shop => 'Tienda';

  @override
  String get achievements => 'Logros';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get gameplayPlaceholder => 'El tablero se renderiza en la fase 3';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get colorBlindMode => 'Modo daltónico';

  @override
  String get reduceMotion => 'Reducir movimiento';

  @override
  String get accessibility => 'Accesibilidad';

  @override
  String get appearance => 'Apariencia';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get hint => 'Pista';

  @override
  String get restart => 'Reiniciar';

  @override
  String get swipeToMove => 'Desliza para mover';

  @override
  String levelTitle(int id) {
    return 'Nivel $id';
  }

  @override
  String movesOptimal(int used, int optimal) {
    return '$used/$optimal óptimo';
  }

  @override
  String get levelComplete => 'Nivel completado';

  @override
  String get moves => 'Movimientos';

  @override
  String optimalLabel(int count) {
    return 'Óptimo: $count';
  }

  @override
  String get coinsEarned => 'Monedas ganadas';

  @override
  String get shareSolution => 'Comparte tu solución';

  @override
  String get nextLevel => 'Siguiente nivel';

  @override
  String get replay => 'Repetir';

  @override
  String get home => 'Inicio';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get doubleCoins => '¡Duplica tus monedas!';

  @override
  String watchAdCoins(int amount) {
    return 'Mira un anuncio para ganar +$amount';
  }

  @override
  String get levels => 'Niveles';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get shareApp => 'Compartir';

  @override
  String get shareAppMessage =>
      '¡Prueba Number Gravity! Predice. Planifica. Resuelve.';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';
}
