import 'package:aog_hymns_app/app/settings/view/about_view.dart';
import 'package:aog_hymns_app/app/settings/view/faq_view.dart';
import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final settings = ref.watch(settingsViewModelProvider);
    final notifier = ref.read(settingsViewModelProvider.notifier);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text(t.navSettings, style: AppFonts.title(null, size: 28)),
        const SizedBox(height: 16),
        Text(t.settingsTheme, style: AppFonts.ui(null, weight: FontWeight.w700)),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          segments: [
            ButtonSegment(value: ThemeMode.system, label: Text(t.themeSystem)),
            ButtonSegment(value: ThemeMode.light, label: Text(t.themeLight)),
            ButtonSegment(value: ThemeMode.dark, label: Text(t.themeDark)),
          ],
          selected: {settings.themeMode},
          onSelectionChanged: (value) => notifier.setTheme(value.first),
        ),
        const SizedBox(height: 20),
        Text(t.settingsText, style: AppFonts.ui(null, weight: FontWeight.w700)),
        const SizedBox(height: 8),
        SegmentedButton<double>(
          segments: [
            ButtonSegment(value: 0.9, label: Text(t.textSmall)),
            ButtonSegment(value: 1, label: Text(t.textMedium)),
            ButtonSegment(value: 1.15, label: Text(t.textLarge)),
          ],
          selected: {settings.textScale},
          onSelectionChanged: (value) => notifier.setTextScale(value.first),
        ),
        const SizedBox(height: 20),
        Text(t.settingsLanguage, style: AppFonts.ui(null, weight: FontWeight.w700)),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: [
            ButtonSegment(value: 'en', label: Text(t.english)),
            ButtonSegment(value: 'fr', label: Text(t.french)),
          ],
          selected: {settings.localeCode},
          onSelectionChanged: (value) => notifier.setLocale(value.first),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () async {
            final ok = await notifier.refreshLibrary();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ok ? t.libraryUpdated : t.libraryUpdateFailed)),
            );
          },
          child: Text(t.refreshLibrary),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () async {
            await notifier.clearDownloads();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(t.downloadsCleared)),
            );
          },
          child: Text(t.clearDownloads),
        ),
        const SizedBox(height: 12),
        ListTile(
          title: Text(t.about),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const AboutView()),
          ),
        ),
        ListTile(
          title: Text(t.faq),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const FaqView()),
          ),
        ),
      ],
    );
  }
}
