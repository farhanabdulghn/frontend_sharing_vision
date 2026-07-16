// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getArticles)
final getArticlesProvider = GetArticlesProvider._();

final class GetArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArticleModel>>,
          List<ArticleModel>,
          FutureOr<List<ArticleModel>>
        >
    with
        $FutureModifier<List<ArticleModel>>,
        $FutureProvider<List<ArticleModel>> {
  GetArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getArticlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getArticlesHash();

  @$internal
  @override
  $FutureProviderElement<List<ArticleModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArticleModel>> create(Ref ref) {
    return getArticles(ref);
  }
}

String _$getArticlesHash() => r'c3705862350912929462271be2658d5f2a8c82ed';

@ProviderFor(getArticle)
final getArticleProvider = GetArticleFamily._();

final class GetArticleProvider
    extends
        $FunctionalProvider<
          AsyncValue<ArticleModel>,
          ArticleModel,
          FutureOr<ArticleModel>
        >
    with $FutureModifier<ArticleModel>, $FutureProvider<ArticleModel> {
  GetArticleProvider._({
    required GetArticleFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getArticleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getArticleHash();

  @override
  String toString() {
    return r'getArticleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ArticleModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ArticleModel> create(Ref ref) {
    final argument = this.argument as int;
    return getArticle(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getArticleHash() => r'4fb85499a6ee50a0011d93ddc0089eab707665e5';

final class GetArticleFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ArticleModel>, int> {
  GetArticleFamily._()
    : super(
        retry: null,
        name: r'getArticleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetArticleProvider call(int id) =>
      GetArticleProvider._(argument: id, from: this);

  @override
  String toString() => r'getArticleProvider';
}
