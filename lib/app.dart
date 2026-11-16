import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/app/splash/view/splash_view.dart';
import 'package:aog_hymns_app/core/theme/app_theme.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AogHymnsApp extends ConsumerWidget {
  const AogHymnsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsViewModelProvider);
    return MaterialApp(
      title: Translations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: Locale(settings.localeCode),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(settings.textScale),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SplashView(),
    );
  }
}
