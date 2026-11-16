import 'dart:io';

import 'package:aog_hymns_app/core/data/catalog_cache.dart';
import 'package:aog_hymns_app/core/data/catalog_codec.dart';
import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('schema mismatch discards the cache file', () async {
    final dir = await Directory.systemTemp.createTemp('aog_cache');
    final cache = CatalogCache(directory: dir);
    final file = File('${dir.path}/aog_hymns_catalog.json');
    await file.writeAsString('{"version": 0, "songs": []}');

    final hymns = await cache.read();

    expect(hymns, isNull);
    expect(file.existsSync(), isFalse);
    await dir.delete(recursive: true);
  });

  test('one hymn round-trips through the catalog codec', () {
    const hymn = HarmonyForgeHymn(
      id: 'h1',
      content: {
        'en': HarmonyForgeContent(
          number: '12',
          title: 'Holy Ground',
          author: 'Test',
          verses: ['We are standing'],
        ),
      },
    );
    final maps = decodeCatalogMaps(encodeCatalog([hymn]));
    final decoded = hymnsFromMaps(maps);
    expect(decoded, hasLength(1));
    expect(decoded.single.content['en']?.title, 'Holy Ground');
  });
}
