import 'package:aog_hymns_app/app/hymn_list/viewmodel/hymn_list_view_model.dart';
import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/data/lyric_repository.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> container(LyricRepository repository) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        lyricRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('empty catalog stays empty', () async {
    final result = await (await container(_FakeRepository(const []))).read(
      hymnListViewModelProvider.future,
    );
    expect(result.hymns, isEmpty);
  });

  test('timeout is a typed failure and does not invent hymns', () async {
    final result = await (await container(_FakeRepository(const [], failure: CatalogFailure.timeout)))
        .read(hymnListViewModelProvider.future);
    expect(result.failure, CatalogFailure.timeout);
    expect(result.hymns, isEmpty);
  });

  test('one sample hymn is listed', () async {
    const hymn = HarmonyForgeHymn(
      id: 'sample',
      content: {
        'en': HarmonyForgeContent(number: '1', title: 'All the Gospel', verses: ['Line']),
      },
    );
    final result = await (await container(_FakeRepository([hymn]))).read(
      hymnListViewModelProvider.future,
    );
    expect(result.hymns.single.songTitle, 'All the Gospel');
    expect(result.hymns.single, isA<Lyric>());
  });
}

class _FakeRepository implements LyricRepository {
  _FakeRepository(this.hymns, {this.failure});

  final List<HarmonyForgeHymn> hymns;
  final CatalogFailure? failure;

  @override
  Future<CatalogLoad> load({required bool french}) async {
    return CatalogLoad(
      lyrics: [
        for (final hymn in hymns) Lyric.fromHarmonyForge(hymn, french: french),
      ],
      failure: failure,
    );
  }

  @override
  Future<CatalogLoad> refresh({required bool french}) => load(french: french);

  @override
  Future<void> clearCache() async {}
}
