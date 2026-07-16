// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_article_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PreviewArticles)
final previewArticlesProvider = PreviewArticlesProvider._();

final class PreviewArticlesProvider
    extends $AsyncNotifierProvider<PreviewArticles, List<ArticleModel>> {
  PreviewArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'previewArticlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$previewArticlesHash();

  @$internal
  @override
  PreviewArticles create() => PreviewArticles();
}

String _$previewArticlesHash() => r'e6943c32f917d187172d9a14d4a6738fa632eadf';

abstract class _$PreviewArticles extends $AsyncNotifier<List<ArticleModel>> {
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
