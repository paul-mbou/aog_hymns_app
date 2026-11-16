import 'package:aog_hymns_app/app/hymn_list/viewmodel/hymn_list_view_model.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_model.g.dart';

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.localeCode,
    required this.textScale,
    required this.favoriteIds,
  });

  final ThemeMode themeMode;
  final String localeCode;
  final double textScale;
  final Set<String> favoriteIds;

  bool french() => localeCode == 'fr';

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? localeCode,
    double? textScale,
    Set<String>? favoriteIds,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      localeCode: localeCode ?? this.localeCode,
      textScale: textScale ?? this.textScale,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

@Riverpod(keepAlive: true)
class SettingsViewModel extends _$SettingsViewModel {
  @override
  AppSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return AppSettings(
      themeMode: _theme(prefs.getString('theme') ?? 'system'),
      localeCode: prefs.getString('locale') ?? 'en',
      textScale: prefs.getDouble('textScale') ?? 1,
      favoriteIds: {...prefs.getStringList('favorites') ?? const []},
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await ref
        .read(sharedPreferencesProvider)
        .setString('theme', _themeName(mode));
  }

  Future<void> setLocale(String code) async {
    await LocaleSettings.setLocaleRaw(code);
    state = state.copyWith(localeCode: code);
    await ref.read(sharedPreferencesProvider).setString('locale', code);
  }

  Future<void> setTextScale(double scale) async {
    state = state.copyWith(textScale: scale);
    await ref.read(sharedPreferencesProvider).setDouble('textScale', scale);
  }

  Future<void> toggleFavorite(String id) async {
    final next = {...state.favoriteIds};
    if (!next.add(id)) next.remove(id);
    state = state.copyWith(favoriteIds: next);
    await ref
        .read(sharedPreferencesProvider)
        .setStringList('favorites', next.toList());
  }

  bool isFavorite(String id) => state.favoriteIds.contains(id);

  Future<bool> refreshLibrary() async {
    final load = await ref
        .read(lyricRepositoryProvider)
        .refresh(french: state.french());
    ref.invalidate(hymnListViewModelProvider);
    return load.failure == null;
  }

  Future<void> clearDownloads() async {
    await ref.read(mediaRepositoryProvider).clear();
    await ref.read(lyricRepositoryProvider).clearCache();
    ref.invalidate(hymnListViewModelProvider);
  }
}

ThemeMode _theme(String raw) => switch (raw) {
  'light' => ThemeMode.light,
  'dark' => ThemeMode.dark,
  _ => ThemeMode.system,
};

String _themeName(ThemeMode mode) => switch (mode) {
  ThemeMode.light => 'light',
  ThemeMode.dark => 'dark',
  ThemeMode.system => 'system',
};
