import 'dart:async';

import 'package:aog_hymns_app/core/data/catalog_cache.dart';
import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/data/firebase_bootstrap.dart';
import 'package:aog_hymns_app/core/model/harmony_forge_hymn.dart';
import 'package:aog_hymns_app/core/model/hymn_number.dart';
import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CatalogLoad {
  const CatalogLoad({required this.lyrics, this.failure});

  final List<Lyric> lyrics;
  final CatalogFailure? failure;

  bool get isEmpty => lyrics.isEmpty;
}

abstract class LyricRepository {
  Future<CatalogLoad> load({required bool french});
  Future<CatalogLoad> refresh({required bool french});
  Future<void> clearCache();
}

class FirestoreLyricRepository implements LyricRepository {
  FirestoreLyricRepository({
    required this.cache,
    this.firestore,
    bool? firebaseReady,
  }) : _firebaseReady = firebaseReady ?? FirebaseBootstrap.ready;

  final CatalogCache cache;
  final FirebaseFirestore? firestore;
  final bool _firebaseReady;
  List<HarmonyForgeHymn>? _memory;

  @override
  Future<CatalogLoad> load({required bool french}) async {
    final cached = _memory ?? await cache.read();
    if (cached != null) {
      _memory = cached;
      return CatalogLoad(lyrics: _toLyrics(cached, french: french));
    }
    return refresh(french: french);
  }

  @override
  Future<CatalogLoad> refresh({required bool french}) async {
    if (!_firebaseReady || firestore == null) {
      return _fallback(french: french, failure: CatalogFailure.notConfigured);
    }
    try {
      final snapshot = await firestore!
          .collection('songs')
          .get(const GetOptions(source: Source.server))
          .timeout(const Duration(seconds: 10));
      final hymns = <HarmonyForgeHymn>[];
      for (final doc in snapshot.docs) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = data['id'] ?? doc.id;
        final hymn = HarmonyForgeHymn.fromJson(data);
        if (hymn.id.isEmpty) continue;
        hymns.add(hymn);
      }
      _memory = hymns;
      await cache.write(hymns);
      return CatalogLoad(lyrics: _toLyrics(hymns, french: french));
    } on TimeoutException {
      return _fallback(french: french, failure: CatalogFailure.timeout);
    } catch (error) {
      if (kDebugMode) debugPrint('Catalog refresh failed');
      return _fallback(french: french, failure: CatalogFailure.unavailable);
    }
  }

  Future<CatalogLoad> _fallback({
    required bool french,
    required CatalogFailure failure,
  }) async {
    final cached = _memory ?? await cache.read();
    if (cached == null) {
      return CatalogLoad(lyrics: const [], failure: failure);
    }
    _memory = cached;
    return CatalogLoad(
      lyrics: _toLyrics(cached, french: french),
      failure: failure,
    );
  }

  @override
  Future<void> clearCache() async {
    _memory = null;
    await cache.clear();
  }

  List<Lyric> _toLyrics(List<HarmonyForgeHymn> hymns, {required bool french}) {
    final lyrics = hymns
        .map((hymn) => Lyric.fromHarmonyForge(hymn, french: french))
        .where((lyric) => lyric.songTitle.isNotEmpty || lyric.verses.isNotEmpty)
        .toList();
    lyrics.sort((a, b) => HymnNumber.compare(a.songNumber, b.songNumber));
    return lyrics;
  }
}
