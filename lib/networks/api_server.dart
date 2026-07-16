import 'package:dio/dio.dart';
import 'package:frontend_sharing_vision/networks/base_api.dart';

enum RequestType { get, post, put, patch, delete }

class ApiServer<T> {
  final Dio _dio;

  ApiServer._(this._dio);

  static ApiServer getInstance() => ApiServer._(ApiClient.instance.dio);

  Future<Response<T>> callService({
    required RequestType requestType,
    required String endPoint,
    T? payload,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final stackTrace = StackTrace.current.toString().split('\n');
    final callerFrame = stackTrace[1];
    final regex = RegExp(r'([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)');
    final match = regex.firstMatch(callerFrame);
    final className = match!.group(1);
    final methodName = match.group(2);

    try {
      late Response<T> response;

      switch (requestType) {
        case RequestType.get:
          response = await _dio.get<T>(
            endPoint,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestType.post:
          response = await _dio.post<T>(
            endPoint,
            data: payload,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestType.put:
          response = await _dio.put<T>(
            endPoint,
            data: payload,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestType.patch:
          response = await _dio.patch<T>(
            endPoint,
            data: payload,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case RequestType.delete:
          response = await _dio.delete<T>(
            endPoint,
            data: payload,
            queryParameters: queryParams,
            options: options,
          );
          break;
      }

      return response;
    } on DioException catch (e) {
      final error =
          '$className#$methodName err : ${e.type == DioExceptionType.connectionError ? 'connectionError' : e.response?.data['message']}';

      throw Exception(error);
    } catch (e) {
      final error = '$className#$methodName err : $e';

      throw Exception(error);
    }
  }
}
