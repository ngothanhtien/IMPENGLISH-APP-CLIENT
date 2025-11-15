// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostResponseImpl _$$PostResponseImplFromJson(Map<String, dynamic> json) =>
    _$PostResponseImpl(
      status: json['status'] as String?,
      total: (json['total'] as num?)?.toInt(),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PostResponseImplToJson(_$PostResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'total': instance.total,
      'data': instance.data,
    };
