// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostDetailResponse _$PostDetailResponseFromJson(Map<String, dynamic> json) {
  return _PostDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$PostDetailResponse {
  String? get status => throw _privateConstructorUsedError;
  PostDetailData? get data => throw _privateConstructorUsedError;

  /// Serializes this PostDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostDetailResponseCopyWith<PostDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailResponseCopyWith<$Res> {
  factory $PostDetailResponseCopyWith(
    PostDetailResponse value,
    $Res Function(PostDetailResponse) then,
  ) = _$PostDetailResponseCopyWithImpl<$Res, PostDetailResponse>;
  @useResult
  $Res call({String? status, PostDetailData? data});

  $PostDetailDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$PostDetailResponseCopyWithImpl<$Res, $Val extends PostDetailResponse>
    implements $PostDetailResponseCopyWith<$Res> {
  _$PostDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = freezed, Object? data = freezed}) {
    return _then(
      _value.copyWith(
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as PostDetailData?,
          )
          as $Val,
    );
  }

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostDetailDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PostDetailDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostDetailResponseImplCopyWith<$Res>
    implements $PostDetailResponseCopyWith<$Res> {
  factory _$$PostDetailResponseImplCopyWith(
    _$PostDetailResponseImpl value,
    $Res Function(_$PostDetailResponseImpl) then,
  ) = __$$PostDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, PostDetailData? data});

  @override
  $PostDetailDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$PostDetailResponseImplCopyWithImpl<$Res>
    extends _$PostDetailResponseCopyWithImpl<$Res, _$PostDetailResponseImpl>
    implements _$$PostDetailResponseImplCopyWith<$Res> {
  __$$PostDetailResponseImplCopyWithImpl(
    _$PostDetailResponseImpl _value,
    $Res Function(_$PostDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = freezed, Object? data = freezed}) {
    return _then(
      _$PostDetailResponseImpl(
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        data:
            freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as PostDetailData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostDetailResponseImpl implements _PostDetailResponse {
  const _$PostDetailResponseImpl({this.status, this.data});

  factory _$PostDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostDetailResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final PostDetailData? data;

  @override
  String toString() {
    return 'PostDetailResponse(status: $status, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailResponseImplCopyWith<_$PostDetailResponseImpl> get copyWith =>
      __$$PostDetailResponseImplCopyWithImpl<_$PostDetailResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostDetailResponseImplToJson(this);
  }
}

abstract class _PostDetailResponse implements PostDetailResponse {
  const factory _PostDetailResponse({
    final String? status,
    final PostDetailData? data,
  }) = _$PostDetailResponseImpl;

  factory _PostDetailResponse.fromJson(Map<String, dynamic> json) =
      _$PostDetailResponseImpl.fromJson;

  @override
  String? get status;
  @override
  PostDetailData? get data;

  /// Create a copy of PostDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDetailResponseImplCopyWith<_$PostDetailResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostDetailData _$PostDetailDataFromJson(Map<String, dynamic> json) {
  return _PostDetailData.fromJson(json);
}

/// @nodoc
mixin _$PostDetailData {
  Post? get post => throw _privateConstructorUsedError;
  List<Comment>? get comments => throw _privateConstructorUsedError;

  /// Serializes this PostDetailData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostDetailDataCopyWith<PostDetailData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailDataCopyWith<$Res> {
  factory $PostDetailDataCopyWith(
    PostDetailData value,
    $Res Function(PostDetailData) then,
  ) = _$PostDetailDataCopyWithImpl<$Res, PostDetailData>;
  @useResult
  $Res call({Post? post, List<Comment>? comments});

  $PostCopyWith<$Res>? get post;
}

/// @nodoc
class _$PostDetailDataCopyWithImpl<$Res, $Val extends PostDetailData>
    implements $PostDetailDataCopyWith<$Res> {
  _$PostDetailDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = freezed, Object? comments = freezed}) {
    return _then(
      _value.copyWith(
            post:
                freezed == post
                    ? _value.post
                    : post // ignore: cast_nullable_to_non_nullable
                        as Post?,
            comments:
                freezed == comments
                    ? _value.comments
                    : comments // ignore: cast_nullable_to_non_nullable
                        as List<Comment>?,
          )
          as $Val,
    );
  }

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res>? get post {
    if (_value.post == null) {
      return null;
    }

    return $PostCopyWith<$Res>(_value.post!, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostDetailDataImplCopyWith<$Res>
    implements $PostDetailDataCopyWith<$Res> {
  factory _$$PostDetailDataImplCopyWith(
    _$PostDetailDataImpl value,
    $Res Function(_$PostDetailDataImpl) then,
  ) = __$$PostDetailDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Post? post, List<Comment>? comments});

  @override
  $PostCopyWith<$Res>? get post;
}

/// @nodoc
class __$$PostDetailDataImplCopyWithImpl<$Res>
    extends _$PostDetailDataCopyWithImpl<$Res, _$PostDetailDataImpl>
    implements _$$PostDetailDataImplCopyWith<$Res> {
  __$$PostDetailDataImplCopyWithImpl(
    _$PostDetailDataImpl _value,
    $Res Function(_$PostDetailDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = freezed, Object? comments = freezed}) {
    return _then(
      _$PostDetailDataImpl(
        post:
            freezed == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as Post?,
        comments:
            freezed == comments
                ? _value._comments
                : comments // ignore: cast_nullable_to_non_nullable
                    as List<Comment>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostDetailDataImpl implements _PostDetailData {
  const _$PostDetailDataImpl({this.post, final List<Comment>? comments})
    : _comments = comments;

  factory _$PostDetailDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostDetailDataImplFromJson(json);

  @override
  final Post? post;
  final List<Comment>? _comments;
  @override
  List<Comment>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PostDetailData(post: $post, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailDataImpl &&
            (identical(other.post, post) || other.post == post) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    post,
    const DeepCollectionEquality().hash(_comments),
  );

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailDataImplCopyWith<_$PostDetailDataImpl> get copyWith =>
      __$$PostDetailDataImplCopyWithImpl<_$PostDetailDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostDetailDataImplToJson(this);
  }
}

abstract class _PostDetailData implements PostDetailData {
  const factory _PostDetailData({
    final Post? post,
    final List<Comment>? comments,
  }) = _$PostDetailDataImpl;

  factory _PostDetailData.fromJson(Map<String, dynamic> json) =
      _$PostDetailDataImpl.fromJson;

  @override
  Post? get post;
  @override
  List<Comment>? get comments;

  /// Create a copy of PostDetailData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDetailDataImplCopyWith<_$PostDetailDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get postId => throw _privateConstructorUsedError;
  UserPost? get userId => throw _privateConstructorUsedError;
  int? get countLike => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? id,
    String? postId,
    UserPost? userId,
    int? countLike,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $UserPostCopyWith<$Res>? get userId;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? postId = freezed,
    Object? userId = freezed,
    Object? countLike = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            postId:
                freezed == postId
                    ? _value.postId
                    : postId // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as UserPost?,
            countLike:
                freezed == countLike
                    ? _value.countLike
                    : countLike // ignore: cast_nullable_to_non_nullable
                        as int?,
            content:
                freezed == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPostCopyWith<$Res>? get userId {
    if (_value.userId == null) {
      return null;
    }

    return $UserPostCopyWith<$Res>(_value.userId!, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
    _$CommentImpl value,
    $Res Function(_$CommentImpl) then,
  ) = __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? id,
    String? postId,
    UserPost? userId,
    int? countLike,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $UserPostCopyWith<$Res>? get userId;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
    _$CommentImpl _value,
    $Res Function(_$CommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? postId = freezed,
    Object? userId = freezed,
    Object? countLike = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CommentImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        postId:
            freezed == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as UserPost?,
        countLike:
            freezed == countLike
                ? _value.countLike
                : countLike // ignore: cast_nullable_to_non_nullable
                    as int?,
        content:
            freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
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
class _$CommentImpl implements _Comment {
  const _$CommentImpl({
    @JsonKey(name: '_id') this.id,
    this.postId,
    this.userId,
    this.countLike,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? postId;
  @override
  final UserPost? userId;
  @override
  final int? countLike;
  @override
  final String? content;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, userId: $userId, countLike: $countLike, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.countLike, countLike) ||
                other.countLike == countLike) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    postId,
    userId,
    countLike,
    content,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment({
    @JsonKey(name: '_id') final String? id,
    final String? postId,
    final UserPost? userId,
    final int? countLike,
    final String? content,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get postId;
  @override
  UserPost? get userId;
  @override
  int? get countLike;
  @override
  String? get content;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
