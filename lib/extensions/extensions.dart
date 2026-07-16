library;

import 'package:dio/dio.dart';

part 'api_extension.dart';
part 'string_nullable_extension.dart';

typedef JsonMapper<T> = T Function(Map<String, dynamic> json);
