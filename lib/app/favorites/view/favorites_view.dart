import 'package:aog_hymns_app/app/favorites/viewmodel/favorites_view_model.dart';
import 'package:aog_hymns_app/app/hymn_detail/view/hymn_detail_view.dart';
import 'package:aog_hymns_app/app/hymn_list/view/empty_catalog.dart';
import 'package:aog_hymns_app/app/hymn_list/view/hymn_tile.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final favorites = ref.watch(favoritesViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(t.navFavorites, style: AppFonts.title(null, size: 28)),
        ),
        Expanded(
          child: favorites.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const EmptyCatalog(),
            data: (hymns) {
              if (hymns.isEmpty) {
                return EmptyCatalog(title: t.favoritesEmptyTitle, body: t.favoritesEmptyBody);
              }
              return ListView.builder(
                itemCount: hymns.length,
                itemBuilder: (context, index) {
                  final lyric = hymns[index];
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
              );
            },
          ),
        ),
      ],
    );
  }
}
