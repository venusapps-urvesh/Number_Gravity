import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../levels/world_config.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_scaffold.dart';

class WorldSelectScreen extends ConsumerWidget {
  const WorldSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return NGScaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.worlds, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.lg),
          ...worldConfigs.map((world) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: NGCard(
                onTap: () => context.go('${AppRoutes.levels}/${world.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'World ${world.id}: ${world.name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(world.mechanic),
                    Text('Levels ${world.startLevel}-${world.endLevel}'),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
