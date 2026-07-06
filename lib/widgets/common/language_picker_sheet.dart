import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';

class AppShare {
  AppShare._();

  static Future<void> shareApp(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Share.share(l10n.shareAppMessage, subject: l10n.appName);
  }

  static Future<void> shareSolution(
    BuildContext context, {
    required String solutionCode,
    required int levelId,
  }) {
    final l10n = AppLocalizations.of(context);
    final message = '${l10n.shareSolution}\n'
        '${l10n.levelTitle(levelId)}: $solutionCode';
    return Share.share(message, subject: l10n.appName);
  }
}

Future<void> showLanguagePicker(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final currentLocale = ref.read(localeProvider).value ??
      Localizations.localeOf(context);

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.selectLanguage,
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
              ),
            ),
            _LanguageTile(
              label: l10n.languageEnglish,
              locale: const Locale('en'),
              groupValue: currentLocale.languageCode,
              onSelected: (locale) => _applyLocale(sheetContext, ref, locale),
            ),
            _LanguageTile(
              label: l10n.languageSpanish,
              locale: const Locale('es'),
              groupValue: currentLocale.languageCode,
              onSelected: (locale) => _applyLocale(sheetContext, ref, locale),
            ),
            _LanguageTile(
              label: l10n.languageFrench,
              locale: const Locale('fr'),
              groupValue: currentLocale.languageCode,
              onSelected: (locale) => _applyLocale(sheetContext, ref, locale),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}

Future<void> _applyLocale(
  BuildContext context,
  WidgetRef ref,
  Locale locale,
) async {
  await ref.read(localeProvider.notifier).setLocale(locale);
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.locale,
    required this.groupValue,
    required this.onSelected,
  });

  final String label;
  final Locale locale;
  final String groupValue;
  final ValueChanged<Locale> onSelected;

  @override
  Widget build(BuildContext context) {
    final selected = locale.languageCode == groupValue;

    return ListTile(
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check_rounded, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () => onSelected(locale),
    );
  }
}

String languageLabelForLocale(AppLocalizations l10n, Locale locale) {
  switch (locale.languageCode) {
    case 'es':
      return l10n.languageSpanish;
    case 'fr':
      return l10n.languageFrench;
    case 'en':
    default:
      return l10n.languageEnglish;
  }
}
