import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:aog_hymns_app/core/model/hymn_number.dart';
import 'package:flutter/foundation.dart';

class Lyric {
  const Lyric({
    required this.id,
    this.songTitle = '',
    this.songNumber = '',
    this.songId = 0,
    this.chorus = '',
    this.key = '',
    this.author = '',
    this.year = '',
    this.verses = const [],
    this.history = '',
    this.audioUrl = '',
    this.partitionUrl = '',
    this.contentLanguage = 'en',
    this.availableInEn = false,
    this.availableInFr = false,
  });

  final String id;
  final String songTitle;
  final String songNumber;
  final int songId;
  final String chorus;
  final String key;
  final String author;
  final String year;
  final List<String> verses;
  final String history;
  final String audioUrl;
  final String partitionUrl;
  final String contentLanguage;
  final bool availableInEn;
  final bool availableInFr;

  static Lyric fromHarmonyForge(HarmonyForgeHymn hymn, {required bool french}) {
    final primaryLang = french ? 'fr' : 'en';
    final fallbackLang = french ? 'en' : 'fr';
    final primary = hymn.content[primaryLang];
    final fallback = hymn.content[fallbackLang];
    final hasEn = hasMeaningfulContent(hymn.content['en']);
    final hasFr = hasMeaningfulContent(hymn.content['fr']);
    if (primary == null) {
      return Lyric(
        id: hymn.id,
        contentLanguage: primaryLang,
        availableInEn: hasEn,
        availableInFr: hasFr,
      );
    }
    final number = primary.number.trim();
    final title = primary.title.trim();
    return Lyric(
      id: hymn.id,
      songTitle: title.isNotEmpty
          ? title
          : (number.isNotEmpty ? 'Hymn $number' : ''),
      songNumber: number,
      songId: HymnNumber.numericPart(number),
      chorus: primary.chorus.trim(),
      key: primary.key.trim(),
      author: primary.author.trim(),
      year: primary.year.trim(),
      verses: primary.verses,
      history: primary.history.trim(),
      audioUrl: _first(primary.audioUrl, fallback?.audioUrl),
      partitionUrl: _first(primary.partitionUrl, fallback?.partitionUrl),
      contentLanguage: primaryLang,
      availableInEn: hasEn,
      availableInFr: hasFr,
    );
  }

  String get displayNumber => songNumber.trim();

  String get displayYear {
    if (year.isNotEmpty) return year;
    return RegExp(r'\b([12][0-9]{3})\b').firstMatch(author)?.group(1) ?? '';
  }

  bool get hasHistory {
    final plain = history.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ').trim();
    return plain.isNotEmpty;
  }

  bool get hasOtherLanguage => contentLanguage == 'fr' ? availableInEn : availableInFr;

  @override
  bool operator ==(Object other) {
    return other is Lyric &&
        other.id == id &&
        other.songTitle == songTitle &&
        other.songNumber == songNumber &&
        other.contentLanguage == contentLanguage &&
        listEquals(other.verses, verses);
  }

  @override
  int get hashCode => Object.hash(id, songTitle, songNumber, contentLanguage, verses.length);
}

String _first(String? first, String? second) {
  final primary = first?.trim() ?? '';
  if (primary.isNotEmpty) return primary;
  return second?.trim() ?? '';
}
