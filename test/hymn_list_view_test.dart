import 'package:aog_hymns_app/app/hymn_list/view/hymn_list_view.dart';
import 'package:aog_hymns_app/core/data/lyric_repository.dart';
import 'package:aog_hymns_app/core/data/providers.dart';
import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpList(WidgetTester tester, LyricRepository repository) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          lyricRepositoryProvider.overrideWithValue(repository),
        ],
        child: TranslationProvider(
          child: const MaterialApp(home: Scaffold(body: HymnListView())),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('empty catalog shows the empty state', (tester) async {
    await pumpList(tester, _Repo(const []));
    expect(find.text('No hymns yet'), findsOneWidget);
  });

  testWidgets('one hymn row shows its title', (tester) async {
    await pumpList(
      tester,
      _Repo(const [
        HarmonyForgeHymn(
          id: 'sample',
          content: {
            'en': HarmonyForgeContent(number: '7', title: 'Amazing Grace', author: 'Newton'),
          },
        ),
      ]),
    );
    expect(find.text('Amazing Grace'), findsOneWidget);
  });
}

class _Repo implements LyricRepository {
  _Repo(this.hymns);
  final List<HarmonyForgeHymn> hymns;

  @override
  Future<CatalogLoad> load({required bool french}) async {
    return CatalogLoad(
      lyrics: [for (final hymn in hymns) Lyric.fromHarmonyForge(hymn, french: french)],
    );
  }

  @override
  Future<CatalogLoad> refresh({required bool french}) => load(french: french);

  @override
  Future<void> clearCache() async {}
}
