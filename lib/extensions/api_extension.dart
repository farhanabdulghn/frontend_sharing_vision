part of 'extensions.dart';

extension ApiExtension on Response {
  bool get isSuccess {
    final data = this.data;
    if (data is Map<String, dynamic>) {
      final status = data['success'];
      return status == true;
    }
    return false;
  }

  List<T> toModelList<T>(JsonMapper<T> fromJson, {String key = 'data'}) {
    return (data[key] as List?)
            ?.map((item) => fromJson(Map<String, dynamic>.from(item)))
            .toList() ??
        [];
  }
}
