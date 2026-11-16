// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'757d5395ba31b078d316dc24d978c8a1ef9ef3f2';

@ProviderFor(catalogCache)
final catalogCacheProvider = CatalogCacheProvider._();

final class CatalogCacheProvider
    extends $FunctionalProvider<CatalogCache, CatalogCache, CatalogCache>
    with $Provider<CatalogCache> {
  CatalogCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogCacheHash();

  @$internal
  @override
  $ProviderElement<CatalogCache> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CatalogCache create(Ref ref) {
    return catalogCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogCache>(value),
    );
  }
}

String _$catalogCacheHash() => r'eb33c5e8f051af3abd3020894dcbbb78350e6df2';

@ProviderFor(lyricRepository)
final lyricRepositoryProvider = LyricRepositoryProvider._();

final class LyricRepositoryProvider
    extends
        $FunctionalProvider<LyricRepository, LyricRepository, LyricRepository>
    with $Provider<LyricRepository> {
  LyricRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricRepositoryHash();

  @$internal
  @override
  $ProviderElement<LyricRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LyricRepository create(Ref ref) {
    return lyricRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LyricRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LyricRepository>(value),
    );
  }
}

String _$lyricRepositoryHash() => r'ca668ed9b2e8ed61e7fb9d8cc3f8c60906c974a7';

@ProviderFor(mediaRepository)
final mediaRepositoryProvider = MediaRepositoryProvider._();

final class MediaRepositoryProvider
    extends
        $FunctionalProvider<MediaRepository, MediaRepository, MediaRepository>
    with $Provider<MediaRepository> {
  MediaRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaRepositoryHash();

  @$internal
  @override
  $ProviderElement<MediaRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MediaRepository create(Ref ref) {
    return mediaRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaRepository>(value),
    );
  }
}

String _$mediaRepositoryHash() => r'190cc98101dc1f7438db8beae99e2093e7ab1f4a';
