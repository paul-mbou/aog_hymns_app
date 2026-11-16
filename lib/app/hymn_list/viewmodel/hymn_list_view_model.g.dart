// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HymnListViewModel)
final hymnListViewModelProvider = HymnListViewModelProvider._();

final class HymnListViewModelProvider
    extends $AsyncNotifierProvider<HymnListViewModel, HymnListState> {
  HymnListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnListViewModelHash();

  @$internal
  @override
  HymnListViewModel create() => HymnListViewModel();
}

String _$hymnListViewModelHash() => r'409c15e71d7d351b677bd8297b09cbf47e431251';

abstract class _$HymnListViewModel extends $AsyncNotifier<HymnListState> {
  FutureOr<HymnListState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HymnListState>, HymnListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HymnListState>, HymnListState>,
              AsyncValue<HymnListState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
