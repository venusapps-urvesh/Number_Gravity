import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../levels/world_config.dart';
import 'routes.dart';

/// Back navigation that follows the app's screen hierarchy instead of the
/// browser-style history stack (which can return to gameplay unexpectedly).
void ngGoBack(BuildContext context) {
  final location = GoRouterState.of(context).matchedLocation;
  final parent = _parentRouteFor(location);

  if (parent != location) {
    context.go(parent);
    return;
  }

  if (context.canPop()) {
    context.pop();
    return;
  }

  context.go(AppRoutes.home);
}

/// Leaves gameplay and opens the level grid for [worldId].
void ngExitPlayToLevels(BuildContext context, int worldId) {
  context.go(AppRoutes.levelsPath(worldId));
}

void ngPushToWorldLevels(BuildContext context, int worldId) {
  context.push(AppRoutes.levelsPath(worldId));
}

void ngPushToPlay(BuildContext context, int levelId) {
  context.push(AppRoutes.playPath(levelId));
}

void ngGoToPlay(BuildContext context, int levelId) {
  context.go(AppRoutes.playPath(levelId));
}

void ngGoHome(BuildContext context) {
  context.go(AppRoutes.home);
}

String _parentRouteFor(String location) {
  if (location == AppRoutes.worlds ||
      location == AppRoutes.daily ||
      location == AppRoutes.leaderboard ||
      location == AppRoutes.shop ||
      location == AppRoutes.achievements ||
      location == AppRoutes.settings ||
      location == AppRoutes.profile ||
      location == AppRoutes.tutorial ||
      location == AppRoutes.howToPlay ||
      location == AppRoutes.zen) {
    return AppRoutes.home;
  }

  if (location.startsWith('${AppRoutes.levels}/')) {
    return AppRoutes.worlds;
  }

  if (location.startsWith('${AppRoutes.play}/')) {
    final levelId = int.tryParse(
      location.substring('${AppRoutes.play}/'.length),
    );
    if (levelId != null) {
      final worldId = _worldIdForLevel(levelId);
      if (worldId != null) {
        return AppRoutes.levelsPath(worldId);
      }
    }
    return AppRoutes.worlds;
  }

  if (location.startsWith('${AppRoutes.victory}/')) {
    return AppRoutes.home;
  }

  return AppRoutes.home;
}

int? _worldIdForLevel(int levelId) {
  for (final world in worldConfigs) {
    if (levelId >= world.startLevel && levelId <= world.endLevel) {
      return world.id;
    }
  }
  return null;
}
