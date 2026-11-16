// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoritesViewModel)
final favoritesViewModelProvider = FavoritesViewModelProvider._();

final class FavoritesViewModelProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Lyric>>,
          List<Lyric>,
          FutureOr<List<Lyric>>
        >
    with $FutureModifier<List<Lyric>>, $FutureProvider<List<Lyric>> {
  FavoritesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesViewModelHash();

  @$internal
  @override
  $FutureProviderElement<List<Lyric>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Lyric>> create(Ref ref) {
    return favoritesViewModel(ref);
  }
}

String _$favoritesViewModelHash() =>
    r'2bedcc6ff985c50dc8e233dc94d7ada76cf78e06';
