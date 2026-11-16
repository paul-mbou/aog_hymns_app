// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HymnDetailViewModel)
final hymnDetailViewModelProvider = HymnDetailViewModelFamily._();

final class HymnDetailViewModelProvider
    extends $AsyncNotifierProvider<HymnDetailViewModel, HymnDetailState> {
  HymnDetailViewModelProvider._({
    required HymnDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hymnDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hymnDetailViewModelHash();

  @override
  String toString() {
    return r'hymnDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HymnDetailViewModel create() => HymnDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is HymnDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hymnDetailViewModelHash() =>
    r'6b5ca81ecb6640b6cada0bec6b3b7fece17311ac';

final class HymnDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          HymnDetailViewModel,
          AsyncValue<HymnDetailState>,
          HymnDetailState,
          FutureOr<HymnDetailState>,
          String
        > {
  HymnDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'hymnDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HymnDetailViewModelProvider call(String id) =>
      HymnDetailViewModelProvider._(argument: id, from: this);

  @override
  String toString() => r'hymnDetailViewModelProvider';
}

abstract class _$HymnDetailViewModel extends $AsyncNotifier<HymnDetailState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<HymnDetailState> build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HymnDetailState>, HymnDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HymnDetailState>, HymnDetailState>,
              AsyncValue<HymnDetailState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
