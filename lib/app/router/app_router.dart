import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import '../../screens/achievements/achievements_screen.dart';
import '../../screens/daily/daily_puzzle_screen.dart';
import '../../screens/gameplay/gameplay_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/how_to_play/how_to_play_screen.dart';
import '../../screens/leaderboard/leaderboard_screen.dart';
import '../../screens/levels/level_select_screen.dart';
import '../../screens/loading/loading_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/shop/shop_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/tutorial/tutorial_screen.dart';
import '../../screens/victory/victory_screen.dart';
import '../../screens/worlds/world_select_screen.dart';
import '../../screens/zen/zen_screen.dart';
import '../../services/leaderboard/leaderboard_service.dart';
import 'routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final storageInit = ref.watch(storageInitProvider);
  final leaderboard = ref.watch(leaderboardServiceProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      if (storageInit.isLoading) {
        return state.matchedLocation == AppRoutes.splash
            ? null
            : AppRoutes.splash;
      }
      if (storageInit.hasError) {
        return null;
      }
      if (state.matchedLocation == AppRoutes.splash) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.loading,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.worlds,
        builder: (context, state) => const WorldSelectScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.levels}/:worldId',
        builder: (context, state) => LevelSelectScreen(
          worldId: int.parse(state.pathParameters['worldId']!),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.play}/:levelId',
        builder: (context, state) => GameplayScreen(
          levelId: int.parse(state.pathParameters['levelId']!),
        ),
      ),
      GoRoute(
        path: AppRoutes.daily,
        builder: (context, state) => DailyPuzzleScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        builder: (context, state) => LeaderboardScreen(service: leaderboard),
      ),
      GoRoute(
        path: AppRoutes.shop,
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.achievements,
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: AppRoutes.tutorial,
        builder: (context, state) => const TutorialScreen(),
      ),
      GoRoute(
        path: AppRoutes.howToPlay,
        builder: (context, state) => const HowToPlayScreen(),
      ),
      GoRoute(
        path: AppRoutes.zen,
        builder: (context, state) => const ZenScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.victory}/:levelId',
        builder: (context, state) {
          final query = state.uri.queryParameters;
          return VictoryScreen(
            levelId: int.parse(state.pathParameters['levelId']!),
            stars: int.parse(query['stars'] ?? '3'),
            moves: int.parse(query['moves'] ?? '0'),
            optimalMoves: int.parse(query['optimal'] ?? '0'),
            coinsEarned: int.parse(query['coins'] ?? '25'),
            solutionCode: query['solution'] ?? '',
            coinBalance: int.parse(query['balance'] ?? '0'),
          );
        },
      ),
    ],
  );
});

final leaderboardServiceProvider = Provider<LeaderboardService>((ref) {
  return LeaderboardServiceStub();
});
