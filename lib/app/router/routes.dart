class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const loading = '/loading';
  static const home = '/home';
  static const worlds = '/worlds';
  static const levels = '/levels';
  static const play = '/play';
  static const daily = '/daily';
  static const settings = '/settings';
  static const leaderboard = '/leaderboard';
  static const shop = '/shop';
  static const profile = '/profile';
  static const achievements = '/achievements';
  static const tutorial = '/tutorial';
  static const zen = '/zen';
  static const victory = '/victory';

  static String levelsPath(int worldId) => '$levels/$worldId';

  static String playPath(int levelId) => '$play/$levelId';

  static String victoryPath(int levelId) => '$victory/$levelId';
}
