// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
  id: json['_id'] as String?,
  userId:
      json['userId'] == null
          ? null
          : UserPost.fromJson(json['userId'] as Map<String, dynamic>),
  title: json['title'] as String?,
  category: json['category'] as String?,
  content: json['content'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  countLike: (json['countLike'] as num?)?.toInt(),
);

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'category': instance.category,
      'content': instance.content,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'countLike': instance.countLike,
    };

_$UserPostImpl _$$UserPostImplFromJson(Map<String, dynamic> json) =>
    _$UserPostImpl(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      streakDay: (json['streakDay'] as num?)?.toInt(),
      level: json['level'] as String?,
    );

Map<String, dynamic> _$$UserPostImplToJson(_$UserPostImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'streakDay': instance.streakDay,
      'level': instance.level,
    };
