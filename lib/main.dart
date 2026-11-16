import 'package:aog_hymns_app/app.dart';
import 'package:aog_hymns_app/core/data/firebase_bootstrap.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) debugPrint(details.exceptionAsString());
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) debugPrint(error.toString());
    return true;
  };
  await FirebaseBootstrap.initialize();
  final preferences = await SharedPreferences.getInstance();
  final localeCode = preferences.getString('locale') ?? 'en';
  await LocaleSettings.setLocaleRaw(localeCode);
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      child: TranslationProvider(child: const AogHymnsApp()),
    ),
  );
}
