import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/common/ng_app_bar.dart';
import '../../widgets/common/ng_scaffold.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    required this.titleKey,
    super.key,
    this.subtitle,
  });

  final String titleKey;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = _titleForKey(l10n, titleKey);

    return NGScaffold(
      appBar: NGAppBar(
        title: title,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
              const SizedBox(height: 16),
              Text(
                l10n.comingSoon,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _titleForKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'worlds':
        return l10n.worlds;
      case 'dailyPuzzle':
        return l10n.dailyPuzzle;
      case 'settings':
        return l10n.settings;
      default:
        return l10n.appName;
    }
  }
}
