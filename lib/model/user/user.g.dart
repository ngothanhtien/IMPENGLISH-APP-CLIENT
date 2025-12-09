// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  userId: json['_id'] as String?,
  email: json['email'] as String?,
  fullName: json['fullName'] as String?,
  phone: json['phone'] as String?,
  provider: json['provider'] as String?,
  googleId: json['googleId'] as String?,
  avatar: json['avatar'] as String?,
  streakDay: (json['streakDay'] as num?)?.toInt(),
  level: json['level'] as String?,
  verify: json['verify'] as bool?,
  status: json['status'] as bool?,
  type: json['type'] as String?,
  createdAt: _fromJsonDate(json['createdAt'] as String?),
  updatedAt: _fromJsonDate(json['updatedAt'] as String?),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'email': instance.email,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'provider': instance.provider,
      'googleId': instance.googleId,
      'avatar': instance.avatar,
      'streakDay': instance.streakDay,
      'level': instance.level,
      'verify': instance.verify,
      'status': instance.status,
      'type': instance.type,
      'createdAt': _toJsonDate(instance.createdAt),
      'updatedAt': _toJsonDate(instance.updatedAt),
    };
