import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_loading.dart';
import '../../widgets/common/ng_scaffold.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageInit = ref.watch(storageInitProvider);
    final l10n = AppLocalizations.of(context);

    return NGScaffold(
      body: Center(
        child: storageInit.when(
          loading: () => NGLoading(message: l10n.loading),
          error: (error, _) => Text(error.toString()),
          data: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.appName,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              NGLoading(message: l10n.loading),
            ],
          ),
        ),
      ),
    );
  }
}
