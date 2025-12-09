// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: "_id")
  String? get userId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  String? get googleId => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  int? get streakDay => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  bool? get verify => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError; // Parse DateTime
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? userId,
    String? email,
    String? fullName,
    String? phone,
    String? provider,
    String? googleId,
    String? avatar,
    int? streakDay,
    String? level,
    bool? verify,
    bool? status,
    String? type,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) DateTime? createdAt,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? email = freezed,
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? provider = freezed,
    Object? googleId = freezed,
    Object? avatar = freezed,
    Object? streakDay = freezed,
    Object? level = freezed,
    Object? verify = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            fullName:
                freezed == fullName
                    ? _value.fullName
                    : fullName // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            provider:
                freezed == provider
                    ? _value.provider
                    : provider // ignore: cast_nullable_to_non_nullable
                        as String?,
            googleId:
                freezed == googleId
                    ? _value.googleId
                    : googleId // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as String?,
            streakDay:
                freezed == streakDay
                    ? _value.streakDay
                    : streakDay // ignore: cast_nullable_to_non_nullable
                        as int?,
            level:
                freezed == level
                    ? _value.level
                    : level // ignore: cast_nullable_to_non_nullable
                        as String?,
            verify:
                freezed == verify
                    ? _value.verify
                    : verify // ignore: cast_nullable_to_non_nullable
                        as bool?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as bool?,
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? userId,
    String? email,
    String? fullName,
    String? phone,
    String? provider,
    String? googleId,
    String? avatar,
    int? streakDay,
    String? level,
    bool? verify,
    bool? status,
    String? type,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) DateTime? createdAt,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? email = freezed,
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? provider = freezed,
    Object? googleId = freezed,
    Object? avatar = freezed,
    Object? streakDay = freezed,
    Object? level = freezed,
    Object? verify = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        fullName:
            freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        provider:
            freezed == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                    as String?,
        googleId:
            freezed == googleId
                ? _value.googleId
                : googleId // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as String?,
        streakDay:
            freezed == streakDay
                ? _value.streakDay
                : streakDay // ignore: cast_nullable_to_non_nullable
                    as int?,
        level:
            freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                    as String?,
        verify:
            freezed == verify
                ? _value.verify
                : verify // ignore: cast_nullable_to_non_nullable
                    as bool?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as bool?,
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    @JsonKey(name: "_id") this.userId,
    this.email,
    this.fullName,
    this.phone,
    this.provider,
    this.googleId,
    this.avatar,
    this.streakDay,
    this.level,
    this.verify,
    this.status,
    this.type,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) this.createdAt,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate) this.updatedAt,
  });

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? userId;
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final String? phone;
  @override
  final String? provider;
  @override
  final String? googleId;
  @override
  final String? avatar;
  @override
  final int? streakDay;
  @override
  final String? level;
  @override
  final bool? verify;
  @override
  final bool? status;
  @override
  final String? type;
  // Parse DateTime
  @override
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  final DateTime? createdAt;
  @override
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(userId: $userId, email: $email, fullName: $fullName, phone: $phone, provider: $provider, googleId: $googleId, avatar: $avatar, streakDay: $streakDay, level: $level, verify: $verify, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.googleId, googleId) ||
                other.googleId == googleId) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.streakDay, streakDay) ||
                other.streakDay == streakDay) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.verify, verify) || other.verify == verify) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    email,
    fullName,
    phone,
    provider,
    googleId,
    avatar,
    streakDay,
    level,
    verify,
    status,
    type,
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    @JsonKey(name: "_id") final String? userId,
    final String? email,
    final String? fullName,
    final String? phone,
    final String? provider,
    final String? googleId,
    final String? avatar,
    final int? streakDay,
    final String? level,
    final bool? verify,
    final bool? status,
    final String? type,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
    final DateTime? createdAt,
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
    final DateTime? updatedAt,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get userId;
  @override
  String? get email;
  @override
  String? get fullName;
  @override
  String? get phone;
  @override
  String? get provider;
  @override
  String? get googleId;
  @override
  String? get avatar;
  @override
  int? get streakDay;
  @override
  String? get level;
  @override
  bool? get verify;
  @override
  bool? get status;
  @override
  String? get type; // Parse DateTime
  @override
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? get createdAt;
  @override
  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
