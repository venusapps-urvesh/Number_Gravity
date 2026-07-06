import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final reduceMotion = ref.watch(reduceMotionProvider).value ?? false;

    return NGScaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(l10n.settings, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(l10n.themeMode),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(l10n.themeSystem)),
              ButtonSegment(value: ThemeMode.light, label: Text(l10n.themeLight)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
            ],
            selected: {themeMode},
            onSelectionChanged: (value) {
              ref.read(themeModeProvider.notifier).setThemeMode(value.first);
            },
          ),
          SwitchListTile(
            title: Text(l10n.colorBlindMode),
            value: colorBlind,
            onChanged: ref.read(colorBlindModeProvider.notifier).setEnabled,
          ),
          SwitchListTile(
            title: Text(l10n.reduceMotion),
            value: reduceMotion,
            onChanged: ref.read(reduceMotionProvider.notifier).setEnabled,
          ),
        ],
      ),
    );
  }
}
