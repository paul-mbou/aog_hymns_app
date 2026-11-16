import 'dart:async';

import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/core/model/hymn_search.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hymn_list_view_model.g.dart';

class HymnListState {
  const HymnListState({
    required this.hymns,
    this.query = '',
    this.failure,
  });

  final List<Lyric> hymns;
  final String query;
  final CatalogFailure? failure;

  List<Lyric> get visible => filterHymns(hymns, query);

  HymnListState copyWith({
    List<Lyric>? hymns,
    String? query,
    CatalogFailure? failure,
    bool clearFailure = false,
  }) {
    return HymnListState(
      hymns: hymns ?? this.hymns,
      query: query ?? this.query,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}

@riverpod
class HymnListViewModel extends _$HymnListViewModel {
  Timer? _debounce;
  var _query = '';

  @override
  Future<HymnListState> build() async {
    ref.onDispose(() => _debounce?.cancel());
    final french = ref.watch(settingsViewModelProvider.select((s) => s.french()));
    final load = await ref.watch(lyricRepositoryProvider).load(french: french);
    return HymnListState(hymns: load.lyrics, query: _query, failure: load.failure);
  }

  void setQuery(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!ref.mounted) return;
      final current = state.asData?.value;
      if (current == null) return;
      _query = value;
      state = AsyncData(current.copyWith(query: value));
    });
  }

  Future<void> refresh() async {
    final french = ref.read(settingsViewModelProvider).french();
    final query = state.asData?.value.query ?? '';
    state = const AsyncLoading();
    final load = await ref.read(lyricRepositoryProvider).refresh(french: french);
    if (!ref.mounted) return;
    state = AsyncData(
      HymnListState(hymns: load.lyrics, query: query, failure: load.failure),
    );
  }
}
