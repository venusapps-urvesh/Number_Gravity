import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../widgets/common/language_picker_sheet.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final reduceMotion = ref.watch(reduceMotionProvider).value ?? false;
    final locale = ref.watch(localeProvider).value ??
        Localizations.localeOf(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.settings, showBack: true),
          Expanded(
            child: NGResponsiveLayout(
              child: ListView(
                children: [
                  Text(l10n.appearance, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.md),
                  NGCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.themeMode, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: AppSpacing.md),
                        SegmentedButton<ThemeMode>(
                          segments: [
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: const Icon(Icons.brightness_auto_rounded, size: 18),
                              label: Text(l10n.themeSystem),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: const Icon(Icons.light_mode_rounded, size: 18),
                              label: Text(l10n.themeLight),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: const Icon(Icons.dark_mode_rounded, size: 18),
                              label: Text(l10n.themeDark),
                            ),
                          ],
                          selected: {themeMode},
                          onSelectionChanged: (selection) {
                            ref
                                .read(themeModeProvider.notifier)
                                .setThemeMode(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(l10n.language, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.md),
                  NGCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.language_rounded, color: muted),
                      title: Text(l10n.language),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            languageLabelForLocale(l10n, locale),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: muted,
                                ),
                          ),
                          const Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                      onTap: () => showLanguagePicker(context, ref),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(l10n.accessibility, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.md),
                  NGCard(
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          secondary: Icon(Icons.visibility_outlined, color: muted),
                          title: Text(l10n.colorBlindMode),
                          value: colorBlind,
                          onChanged: ref.read(colorBlindModeProvider.notifier).setEnabled,
                        ),
                        const Divider(),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          secondary: Icon(Icons.motion_photos_off_outlined, color: muted),
                          title: Text(l10n.reduceMotion),
                          value: reduceMotion,
                          onChanged: ref.read(reduceMotionProvider.notifier).setEnabled,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
