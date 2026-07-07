import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';

class AppShare {
  AppShare._();

  static Future<void> shareApp(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SharePlus.instance.share(
      ShareParams(text: l10n.shareAppMessage, subject: l10n.appName),
    );
  }

  static Future<void> shareSolution(
    BuildContext context, {
    required String solutionCode,
    required int levelId,
  }) {
    final l10n = AppLocalizations.of(context);
    final message =
        '${l10n.shareSolution}\n'
        '${l10n.levelTitle(levelId)}: $solutionCode';
    return SharePlus.instance.share(
      ShareParams(text: message, subject: l10n.appName),
    );
  }
}

Future<void> showLanguagePicker(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final currentLocale =
      ref.read(localeProvider).value ?? Localizations.localeOf(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (dialogContext) {
      final brightness = Theme.of(dialogContext).brightness;
      final surface = brightness == Brightness.dark
          ? AppColors.darkSurface
          : AppColors.lightSurface;
      final border = AppColors.surfaceBorder(brightness);

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: brightness == Brightness.dark ? 0.35 : 0.18,
                  ),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.selectLanguage,
                  style: Theme.of(
                    dialogContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: AppSpacing.md),
                _LanguageOption(
                  label: l10n.languageEnglish,
                  locale: const Locale('en'),
                  groupValue: currentLocale.languageCode,
                  onSelected: (locale) =>
                      _applyLocale(dialogContext, ref, locale),
                ),
                const SizedBox(height: AppSpacing.sm),
                _LanguageOption(
                  label: l10n.languageSpanish,
                  locale: const Locale('es'),
                  groupValue: currentLocale.languageCode,
                  onSelected: (locale) =>
                      _applyLocale(dialogContext, ref, locale),
                ),
                const SizedBox(height: AppSpacing.sm),
                _LanguageOption(
                  label: l10n.languageFrench,
                  locale: const Locale('fr'),
                  groupValue: currentLocale.languageCode,
                  onSelected: (locale) =>
                      _applyLocale(dialogContext, ref, locale),
                ),
              ],
            ),
          ),
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

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
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
    final brightness = Theme.of(context).brightness;
    final border = AppColors.surfaceBorder(brightness);
    final primary = Theme.of(context).colorScheme.primary;

    return Material(
      color: selected ? primary.withValues(alpha: 0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onSelected(locale),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? primary : border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: primary, size: 22),
            ],
          ),
        ),
      ),
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
