import 'package:aog_hymns_app/core/model/lyric.dart';

String normalizeForSearch(String input) {
  final plain = input
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .toLowerCase();
  return _fold(plain).replaceAll(RegExp(r'[^a-z0-9\s]+'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
}

List<Lyric> filterHymns(List<Lyric> hymns, String query) {
  final normalized = normalizeForSearch(query);
  if (normalized.isEmpty) return hymns;
  final words = normalized.split(' ');
  final scored = <({Lyric lyric, int score})>[];
  for (final lyric in hymns) {
    final score = _score(lyric, normalized, words);
    if (score > 0) scored.add((lyric: lyric, score: score));
  }
  scored.sort((a, b) => b.score.compareTo(a.score));
  return scored.map((entry) => entry.lyric).toList();
}

int _score(Lyric lyric, String query, List<String> words) {
  final title = normalizeForSearch(lyric.songTitle);
  final author = normalizeForSearch(lyric.author);
  final number = normalizeForSearch(lyric.displayNumber);
  final body = normalizeForSearch([lyric.chorus, ...lyric.verses].join(' '));
  final haystack = '$title $author $number $body';
  if (words.any((word) => !haystack.contains(word))) return 0;
  var score = 0;
  if (number.isNotEmpty && (number == query || words.contains(number))) score += 200;
  if (title.contains(query)) score += 120;
  if (author.contains(query)) score += 50;
  if (body.contains(query)) score += 80;
  return score;
}

String _fold(String input) {
  const from = 'àáâãäåçèéêëìíîïñòóôõöùúûüýÿœæ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyyoeae';
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    final index = from.indexOf(ch);
    buffer.write(index >= 0 ? to[index] : ch);
  }
  return buffer.toString();
}
