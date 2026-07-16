// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) =>
    _ArticleModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String?,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
    );

Map<String, dynamic> _$ArticleModelToJson(_ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'status': instance.status,
      'created_date': instance.createdDate?.toIso8601String(),
      'updated_date': instance.updatedDate?.toIso8601String(),
    };
