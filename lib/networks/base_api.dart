import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:frontend_sharing_vision/config/env.dart';

class BaseApi {
  final String baseUrl;

  BaseApi(this.baseUrl);

  Dio _dio() {
    return Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 45),
          sendTimeout: Duration(seconds: 30),
          contentType: 'application/json;charset=UTF-8',
          headers: {'Charset': 'utf-8'},
        ),
      )
      ..interceptors.addAll([
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            return handler.next(options);
          },
          onError: (error, handler) {
            if (error.type == DioExceptionType.connectionError) {
              log('No Internet Connection');
            }
            return handler.next(error);
          },
        ),
      ]);
  }

  Dio get dio => _dio();
}

class ApiClient extends BaseApi {
  ApiClient() : super(Environment.config.baseUrl);
  static ApiClient? _instance;
  static ApiClient get instance => _instance == null ? ApiClient() : _instance!;
}
