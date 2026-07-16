// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_handle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PageHandleNotifier)
final pageHandleProvider = PageHandleNotifierProvider._();

final class PageHandleNotifierProvider
    extends $NotifierProvider<PageHandleNotifier, int> {
  PageHandleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pageHandleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pageHandleNotifierHash();

  @$internal
  @override
  PageHandleNotifier create() => PageHandleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pageHandleNotifierHash() =>
    r'4a5c429fec69f43711f851a793b8e6b4eea8ac2b';

abstract class _$PageHandleNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
