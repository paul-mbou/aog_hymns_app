import 'dart:convert';

import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';

const catalogSchemaVersion = 1;

/// Top-level so [Isolate.run] can decode a full songs export off the UI isolate.
List<Map<String, dynamic>> decodeCatalogMaps(String raw) {
  final decoded = jsonDecode(raw);
  if (decoded is! Map) return const [];
  if (decoded['version'] != catalogSchemaVersion) {
    throw const FormatException('schema');
  }
  final songs = decoded['songs'];
  if (songs is! List) return const [];
  return [
    for (final song in songs)
      if (song is Map) Map<String, dynamic>.from(song),
  ];
}

String encodeCatalog(List<HarmonyForgeHymn> hymns) {
  return jsonEncode({
    'version': catalogSchemaVersion,
    'songs': hymns.map((hymn) => hymn.toJson()).toList(),
  });
}

List<HarmonyForgeHymn> hymnsFromMaps(List<Map<String, dynamic>> maps) {
  return [
    for (final map in maps)
      if ((map['id'] ?? '').toString().isNotEmpty) HarmonyForgeHymn.fromJson(map),
  ];
}
