// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostDetailResponseImpl _$$PostDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PostDetailResponseImpl(
  status: json['status'] as String?,
  data:
      json['data'] == null
          ? null
          : PostDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PostDetailResponseImplToJson(
  _$PostDetailResponseImpl instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

_$PostDetailDataImpl _$$PostDetailDataImplFromJson(Map<String, dynamic> json) =>
    _$PostDetailDataImpl(
      post:
          json['post'] == null
              ? null
              : Post.fromJson(json['post'] as Map<String, dynamic>),
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PostDetailDataImplToJson(
  _$PostDetailDataImpl instance,
) => <String, dynamic>{'post': instance.post, 'comments': instance.comments};

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['_id'] as String?,
      postId: json['postId'] as String?,
      userId: json['userId'] as String?,
      countLike: (json['countLike'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'countLike': instance.countLike,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
