class HarmonyForgeContent {
  const HarmonyForgeContent({
    this.number = '',
    this.title = '',
    this.author = '',
    this.chorus = '',
    this.year = '',
    this.key = '',
    this.verses = const [],
    this.history = '',
    this.partitionUrl = '',
    this.audioUrl = '',
  });

  final String number;
  final String title;
  final String author;
  final String chorus;
  final String year;
  final String key;
  final List<String> verses;
  final String history;
  final String partitionUrl;
  final String audioUrl;

  factory HarmonyForgeContent.fromJson(
    Map<String, dynamic>? json, {
    String legacyPartition = '',
    String legacyAudio = '',
  }) {
    if (json == null) return const HarmonyForgeContent();
    return HarmonyForgeContent(
      number: _string(json['number']),
      title: _string(json['title']),
      author: _string(json['author']),
      chorus: _string(json['chorus']),
      year: _string(json['year']),
      key: _string(json['key']),
      verses: _verses(json['verses']),
      history: _string(json['history']),
      partitionUrl: _first(_string(json['partitionUrl']), legacyPartition),
      audioUrl: _first(_string(json['audioUrl']), legacyAudio),
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'title': title,
    'author': author,
    'chorus': chorus,
    'year': year,
    'key': key,
    'verses': verses,
    'history': history,
    'partitionUrl': partitionUrl,
    'audioUrl': audioUrl,
  };
}

class HarmonyForgeHymn {
  const HarmonyForgeHymn({required this.id, required this.content});

  final String id;
  final Map<String, HarmonyForgeContent> content;

  factory HarmonyForgeHymn.fromJson(Map<String, dynamic> json) {
    final rawContent = json['content'];
    final content = <String, HarmonyForgeContent>{};
    final legacyPartition = _string(json['partitionUrl']);
    final legacyAudio = _string(json['audioUrl']);
    if (rawContent is Map) {
      for (final entry in rawContent.entries) {
        final value = entry.value;
        content[entry.key.toString()] = HarmonyForgeContent.fromJson(
          value is Map ? Map<String, dynamic>.from(value) : null,
          legacyPartition: legacyPartition,
          legacyAudio: legacyAudio,
        );
      }
    }
    final id = _string(json['id']);
    return HarmonyForgeHymn(id: id.isEmpty ? _string(json['docId']) : id, content: content);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content.map((key, value) => MapEntry(key, value.toJson())),
  };
}

bool hasMeaningfulContent(HarmonyForgeContent? content) {
  if (content == null) return false;
  if (content.title.trim().isNotEmpty) return true;
  if (content.chorus.trim().isNotEmpty) return true;
  return content.verses.any((verse) => verse.trim().isNotEmpty);
}

String _string(Object? value) => value?.toString().trim() ?? '';

String _first(String primary, String fallback) => primary.isNotEmpty ? primary : fallback;

List<String> _verses(Object? value) {
  if (value is! List) return const [];
  return value.map((item) => item.toString()).toList();
}
