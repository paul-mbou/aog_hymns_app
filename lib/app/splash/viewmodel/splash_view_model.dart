import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  Future<void> build() async {
    final repo = ref.watch(lyricRepositoryProvider);
    final french = ref.watch(settingsViewModelProvider.select((s) => s.french()));
    final started = DateTime.now();
    try {
      final cached = await repo.load(french: french);
      if (cached.lyrics.isEmpty && cached.failure == null) {
        await repo.refresh(french: french);
      }
    } catch (_) {
      // The hymn list shows the empty or offline state.
    }
    final elapsed = DateTime.now().difference(started);
    const minimum = Duration(milliseconds: 1400);
    if (elapsed < minimum) {
      await Future<void>.delayed(minimum - elapsed);
    }
    if (!ref.mounted) return;
  }
}
