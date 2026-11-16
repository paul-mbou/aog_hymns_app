import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HymnTile extends ConsumerWidget {
  const HymnTile({super.key, required this.lyric, required this.onTap});

  final Lyric lyric;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite = ref.watch(
      settingsViewModelProvider.select((settings) => settings.favoriteIds.contains(lyric.id)),
    );
    final scheme = Theme.of(context).colorScheme;
    final title = lyric.songTitle.isEmpty
        ? Translations.of(context).untitledHymn
        : lyric.songTitle;
    final meta = [
      if (lyric.author.isNotEmpty) lyric.author,
      if (lyric.displayYear.isNotEmpty) lyric.displayYear,
    ].join(' · ');
    final badge = lyric.displayNumber.isEmpty
        ? '—'
        : (lyric.displayNumber.length < 3 && int.tryParse(lyric.displayNumber) != null
              ? lyric.displayNumber.padLeft(2, '0')
              : lyric.displayNumber);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        child: Text(badge, style: AppFonts.ui(null, weight: FontWeight.w700, size: 13)),
      ),
      title: Text(title, style: AppFonts.title(null, size: 18)),
      subtitle: meta.isEmpty ? null : Text(meta, style: AppFonts.ui(null)),
      trailing: IconButton(
        onPressed: () => ref.read(settingsViewModelProvider.notifier).toggleFavorite(lyric.id),
        icon: Icon(favorite ? LucideIcons.heart : LucideIcons.heart, fill: favorite ? 1 : 0),
        color: scheme.primary,
      ),
    );
  }
}
