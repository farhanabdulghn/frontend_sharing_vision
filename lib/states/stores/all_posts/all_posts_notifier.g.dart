// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_posts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AllPostsNotifier)
final allPostsProvider = AllPostsNotifierProvider._();

final class AllPostsNotifierProvider
    extends $AsyncNotifierProvider<AllPostsNotifier, List<ArticleModel>> {
  AllPostsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPostsNotifierHash();

  @$internal
  @override
  AllPostsNotifier create() => AllPostsNotifier();
}

String _$allPostsNotifierHash() => r'b7054afd45e8a0295c876f38324b03015dc71e60';

abstract class _$AllPostsNotifier extends $AsyncNotifier<List<ArticleModel>> {
  FutureOr<List<ArticleModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ArticleModel>>, List<ArticleModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ArticleModel>>, List<ArticleModel>>,
              AsyncValue<List<ArticleModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
