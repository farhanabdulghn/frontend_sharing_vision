import 'package:frontend_sharing_vision/models/article/article_model.dart';
import 'package:frontend_sharing_vision/networks/repositories/article_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_state.g.dart';

final _repository = ArticleRepository();

@riverpod
Future<List<ArticleModel>> getArticles(Ref ref) {
  return _repository.getArticles();
}

@riverpod
Future<ArticleModel> getArticle(Ref ref, int id) {
  return _repository.getArticle(id);
}
