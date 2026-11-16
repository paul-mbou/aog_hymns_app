import 'package:aog_hymns_app/core/data/catalog_cache.dart';
import 'package:aog_hymns_app/core/data/dio_client.dart';
import 'package:aog_hymns_app/core/data/firebase_bootstrap.dart';
import 'package:aog_hymns_app/core/data/lyric_repository.dart';
import 'package:aog_hymns_app/core/data/media_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main.');
}

@Riverpod(keepAlive: true)
CatalogCache catalogCache(Ref ref) => CatalogCache();

@Riverpod(keepAlive: true)
LyricRepository lyricRepository(Ref ref) {
  return FirestoreLyricRepository(
    cache: ref.watch(catalogCacheProvider),
    firestore: FirebaseBootstrap.ready ? FirebaseFirestore.instance : null,
    firebaseReady: FirebaseBootstrap.ready,
  );
}

@Riverpod(keepAlive: true)
MediaRepository mediaRepository(Ref ref) {
  return MediaRepository(ref.watch(dioProvider));
}
