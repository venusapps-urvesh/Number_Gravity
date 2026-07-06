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

  @override
  String get profile => 'Perfil';

  @override
  String get statLevels => 'Niveles';

  @override
  String get statStars => 'Estrellas';

  @override
  String get statEarnedCoins => 'Ganadas';

  @override
  String get worldProgress => 'Progreso de mundos';

  @override
  String dayStreak(int count) {
    return 'Racha de $count días';
  }

  @override
  String get totalMovesLabel => 'Movimientos totales';

  @override
  String get hintsUsedLabel => 'Pistas usadas';

  @override
  String get coinsEarnedTab => 'Monedas ganadas';

  @override
  String get skillLadderTab => 'Escala de habilidad';

  @override
  String get scopeGlobal => 'Global';

  @override
  String get scopeWeekly => 'Semanal';

  @override
  String get scopeFriends => 'Amigos';

  @override
  String get you => 'Tú';

  @override
  String get leaderboardFairness =>
      'Clasifica solo por monedas ganadas jugando — se excluyen las compradas y las de anuncios. El rango no se puede comprar.';

  @override
  String get leaderboardEmpty =>
      'Aún no hay clasificación. Juega niveles para ganar tu lugar.';

  @override
  String get starterPack => 'Pack inicial';

  @override
  String get starterPackDesc => 'Monedas + un tema · una vez';

  @override
  String get packPouch => 'Bolsa';

  @override
  String get packBag => 'Mochila';

  @override
  String get packChest => 'Cofre';

  @override
  String get packVault => 'Bóveda';

  @override
  String bonusPercent(int percent) {
    return '+$percent%';
  }

  @override
  String coinCount(int count) {
    return '$count monedas';
  }

  @override
  String get bestValue => 'Mejor valor';

  @override
  String get watchAnAd => 'Ver un anuncio';

  @override
  String adRewardAmount(int amount) {
    return '+$amount';
  }

  @override
  String get adsOptIn => 'Los anuncios son opcionales — nunca forzados.';

  @override
  String get claim => 'Reclamar';

  @override
  String get claimed => 'Reclamado';

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total';
  }

  @override
  String get achFirstWorldTitle => 'Conquistador de Mundos';

  @override
  String get achFirstWorldDesc => 'Termina el Mundo 1';

  @override
  String get achPerfectTitle => 'Perfeccionista';

  @override
  String get achPerfectDesc => 'Gana 3 estrellas en 10 niveles';

  @override
  String get achStreakTitle => 'Guerrero Semanal';

  @override
  String get achStreakDesc => 'Alcanza una racha de 7 días';

  @override
  String get achNoHintTitle => 'Héroe Sin Pistas';

  @override
  String get achNoHintDesc => 'Supera 25 niveles sin pistas';

  @override
  String get achSpeedTitle => 'Solucionador Veloz';

  @override
  String get achSpeedDesc => 'Resuelve 30 niveles de forma óptima';

  @override
  String get achDailyTitle => 'Devoto Diario';

  @override
  String get achDailyDesc => 'Completa 30 puzzles diarios';

  @override
  String dailySeed(String date) {
    return 'Semilla · $date · mismo tablero en todo el mundo';
  }

  @override
  String get solveTodaysPuzzle => 'Resuelve el puzzle de hoy';

  @override
  String get skillLadderNote =>
      'Los menos movimientos te clasifican en la escala de habilidad no comprable';

  @override
  String get streak => 'Racha';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get tutorialTitle1 => 'Las fichas azules atraen.';

  @override
  String get tutorialBody1 =>
      'Los números positivos atraen las fichas cercanas. Desliza +3 hacia la estrella.';

  @override
  String get tutorialTitle2 => 'Las fichas rojas empujan.';

  @override
  String get tutorialBody2 =>
      'Los números negativos repelen. Úsalos para desviar fichas.';

  @override
  String get tutorialTitle3 => 'Planifica cada movimiento.';

  @override
  String get tutorialBody3 =>
      'Las vistas previas muestran dónde se asienta la gravedad antes de mover.';

  @override
  String tutorialStep(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get startPlaying => 'Empezar Nivel 1';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get zenMode => 'Modo Zen';

  @override
  String get zenSubtitle => 'Sin estrellas · sin cronómetro · sin fallar';

  @override
  String get zenBody => 'Relájate y experimenta. Resuelve a tu ritmo.';

  @override
  String get startZen => 'Empezar un tablero Zen';
}
