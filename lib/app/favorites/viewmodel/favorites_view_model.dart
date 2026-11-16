import 'package:aog_hymns_app/app/hymn_list/viewmodel/hymn_list_view_model.dart';
import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.g.dart';

@riverpod
Future<List<Lyric>> favoritesViewModel(Ref ref) async {
  final ids = ref.watch(settingsViewModelProvider.select((s) => s.favoriteIds));
  final list = await ref.watch(hymnListViewModelProvider.future);
  return list.hymns.where((lyric) => ids.contains(lyric.id)).toList();
}
