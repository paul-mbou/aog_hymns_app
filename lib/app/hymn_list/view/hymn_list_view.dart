import 'package:aog_hymns_app/app/hymn_detail/view/hymn_detail_view.dart';
import 'package:aog_hymns_app/app/hymn_list/view/empty_catalog.dart';
import 'package:aog_hymns_app/app/hymn_list/view/hymn_tile.dart';
import 'package:aog_hymns_app/app/hymn_list/viewmodel/hymn_list_view_model.dart';
import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HymnListView extends ConsumerStatefulWidget {
  const HymnListView({super.key});

  @override
  ConsumerState<HymnListView> createState() => _HymnListViewState();
}

class _HymnListViewState extends ConsumerState<HymnListView> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final catalog = ref.watch(hymnListViewModelProvider);
    final locale = ref.watch(settingsViewModelProvider.select((s) => s.localeCode));
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(t.appTitle, style: AppFonts.title(null, size: 28)),
              ),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'en', label: Text(t.languageEn)),
                  ButtonSegment(value: 'fr', label: Text(t.languageFr)),
                ],
                selected: {locale},
                onSelectionChanged: (value) {
                  ref.read(settingsViewModelProvider.notifier).setLocale(value.first);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: t.searchHint,
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) => ref.read(hymnListViewModelProvider.notifier).setQuery(value),
          ),
        ),
        Expanded(
          child: catalog.when(
            loading: () => Center(child: CircularProgressIndicator(color: scheme.primary)),
            error: (_, _) => const _LoadError(),
            data: (state) {
              final rows = state.visible;
              if (rows.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => ref.read(hymnListViewModelProvider.notifier).refresh(),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 420,
                        child: EmptyCatalog(failure: state.query.isEmpty ? state.failure : null),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => ref.read(hymnListViewModelProvider.notifier).refresh(),
                child: ListView.builder(
                  itemCount: rows.length,
                  itemBuilder: (context, index) {
                    final lyric = rows[index];
                    return HymnTile(
                      lyric: lyric,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => HymnDetailView(hymnId: lyric.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LoadError extends ConsumerWidget {
  const _LoadError();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.couldNotLoad, style: AppFonts.ui(null, size: 16)),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => ref.read(hymnListViewModelProvider.notifier).refresh(),
            child: Text(t.retry),
          ),
        ],
      ),
    );
  }
}
