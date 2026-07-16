import 'package:frontend_sharing_vision/extensions/extensions.dart';
import 'package:frontend_sharing_vision/models/article/article_model.dart';
import 'package:frontend_sharing_vision/networks/api_server.dart';

class ArticleRepository {
  final _apiServer = ApiServer.getInstance();

  Future<List<ArticleModel>> getArticles() async {
    final response = await _apiServer.callService(
      requestType: RequestType.get,
      endPoint: '/article/10/0',
    );

    return response.toModelList(ArticleModel.fromJson);
  }

  Future<ArticleModel> getArticle(int id) async {
    final response = await _apiServer.callService(
      requestType: RequestType.get,
      endPoint: '/article/$id',
    );

    return ArticleModel.fromJson(response.data['data']);
  }

  Future<bool> addArticle({
    required String title,
    required String content,
    required String category,
    required String status,
  }) async {
    final queryParams = <String, dynamic>{
      'title': title,
      'content': content,
      'category': category,
      'status': status,
    };

    final response = await _apiServer.callService(
      requestType: RequestType.post,
      endPoint: '/article',
      queryParams: queryParams,
    );

    return response.isSuccess;
  }

  Future<bool> updateArticle({
    required int id,
    String? title,
    String? content,
    String? category,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{};

    if (title.hasValue) queryParams['title'] = title;
    if (content.hasValue) queryParams['content'] = content;
    if (category.hasValue) queryParams['category'] = category;
    if (status.hasValue) queryParams['status'] = status;

    final response = await _apiServer.callService(
      requestType: RequestType.put,
      endPoint: '/article/$id',
      queryParams: queryParams,
    );

    return response.isSuccess;
  }

  Future<bool> deleteArticle(int id) async {
    final queryParams = <String, dynamic>{};

    final response = await _apiServer.callService(
      requestType: RequestType.delete,
      endPoint: '/article/$id',
      queryParams: queryParams,
    );

    return response.isSuccess;
  }
}
