import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../levels/world_config.dart';
import 'routes.dart';

/// Pops the navigation stack when possible; otherwise navigates to a parent route.
void ngGoBack(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }

  context.go(_parentRouteFor(GoRouterState.of(context).matchedLocation));
}

String _parentRouteFor(String location) {
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
        return '${AppRoutes.levels}/$worldId';
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
