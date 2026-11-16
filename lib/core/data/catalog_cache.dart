import 'dart:io';
import 'dart:isolate';

import 'package:aog_hymns_app/core/data/catalog_codec.dart';
import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CatalogCache {
  CatalogCache({this.directory});

  final Directory? directory;

  Future<File> _file() async {
    final dir = directory ?? await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'aog_hymns_catalog.json'));
  }

  Future<bool> hasCatalog() async => (await _file()).exists();

  Future<List<HarmonyForgeHymn>?> read() async {
    final file = await _file();
    if (!file.existsSync()) return null;
    try {
      final raw = await file.readAsString();
      final maps = await Isolate.run(() => decodeCatalogMaps(raw));
      return hymnsFromMaps(maps);
    } on FormatException {
      await file.delete();
      return null;
    } catch (_) {
      await file.delete();
      return null;
    }
  }

  Future<void> write(List<HarmonyForgeHymn> hymns) async {
    final file = await _file();
    final temp = File('${file.path}.part');
    await temp.writeAsString(encodeCatalog(hymns));
    if (file.existsSync()) await file.delete();
    await temp.rename(file.path);
  }

  Future<void> clear() async {
    final file = await _file();
    if (file.existsSync()) await file.delete();
  }
}
