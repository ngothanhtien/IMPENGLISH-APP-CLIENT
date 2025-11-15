// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocab_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VocabDetailResponse _$VocabDetailResponseFromJson(Map<String, dynamic> json) {
  return _VocabDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$VocabDetailResponse {
  String? get title => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: "detail")
  IVocabDetail? get detail => throw _privateConstructorUsedError;

  /// Serializes this VocabDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabDetailResponseCopyWith<VocabDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabDetailResponseCopyWith<$Res> {
  factory $VocabDetailResponseCopyWith(
    VocabDetailResponse value,
    $Res Function(VocabDetailResponse) then,
  ) = _$VocabDetailResponseCopyWithImpl<$Res, VocabDetailResponse>;
  @useResult
  $Res call({
    String? title,
    String? message,
    @JsonKey(name: "detail") IVocabDetail? detail,
  });

  $IVocabDetailCopyWith<$Res>? get detail;
}

/// @nodoc
class _$VocabDetailResponseCopyWithImpl<$Res, $Val extends VocabDetailResponse>
    implements $VocabDetailResponseCopyWith<$Res> {
  _$VocabDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? message = freezed,
    Object? detail = freezed,
  }) {
    return _then(
      _value.copyWith(
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            detail:
                freezed == detail
                    ? _value.detail
                    : detail // ignore: cast_nullable_to_non_nullable
                        as IVocabDetail?,
          )
          as $Val,
    );
  }

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IVocabDetailCopyWith<$Res>? get detail {
    if (_value.detail == null) {
      return null;
    }

    return $IVocabDetailCopyWith<$Res>(_value.detail!, (value) {
      return _then(_value.copyWith(detail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VocabDetailResponseImplCopyWith<$Res>
    implements $VocabDetailResponseCopyWith<$Res> {
  factory _$$VocabDetailResponseImplCopyWith(
    _$VocabDetailResponseImpl value,
    $Res Function(_$VocabDetailResponseImpl) then,
  ) = __$$VocabDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    String? message,
    @JsonKey(name: "detail") IVocabDetail? detail,
  });

  @override
  $IVocabDetailCopyWith<$Res>? get detail;
}

/// @nodoc
class __$$VocabDetailResponseImplCopyWithImpl<$Res>
    extends _$VocabDetailResponseCopyWithImpl<$Res, _$VocabDetailResponseImpl>
    implements _$$VocabDetailResponseImplCopyWith<$Res> {
  __$$VocabDetailResponseImplCopyWithImpl(
    _$VocabDetailResponseImpl _value,
    $Res Function(_$VocabDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? message = freezed,
    Object? detail = freezed,
  }) {
    return _then(
      _$VocabDetailResponseImpl(
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        detail:
            freezed == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                    as IVocabDetail?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabDetailResponseImpl implements _VocabDetailResponse {
  const _$VocabDetailResponseImpl({
    this.title,
    this.message,
    @JsonKey(name: "detail") this.detail,
  });

  factory _$VocabDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabDetailResponseImplFromJson(json);

  @override
  final String? title;
  @override
  final String? message;
  @override
  @JsonKey(name: "detail")
  final IVocabDetail? detail;

  @override
  String toString() {
    return 'VocabDetailResponse(title: $title, message: $message, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabDetailResponseImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, message, detail);

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabDetailResponseImplCopyWith<_$VocabDetailResponseImpl> get copyWith =>
      __$$VocabDetailResponseImplCopyWithImpl<_$VocabDetailResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabDetailResponseImplToJson(this);
  }
}

abstract class _VocabDetailResponse implements VocabDetailResponse {
  const factory _VocabDetailResponse({
    final String? title,
    final String? message,
    @JsonKey(name: "detail") final IVocabDetail? detail,
  }) = _$VocabDetailResponseImpl;

  factory _VocabDetailResponse.fromJson(Map<String, dynamic> json) =
      _$VocabDetailResponseImpl.fromJson;

  @override
  String? get title;
  @override
  String? get message;
  @override
  @JsonKey(name: "detail")
  IVocabDetail? get detail;

  /// Create a copy of VocabDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabDetailResponseImplCopyWith<_$VocabDetailResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IVocabDetail _$IVocabDetailFromJson(Map<String, dynamic> json) {
  return _IVocabDetail.fromJson(json);
}

/// @nodoc
mixin _$IVocabDetail {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get meaningVN => throw _privateConstructorUsedError;
  List<IDefinitions>? get meanings => throw _privateConstructorUsedError;
  List<IPhonetic>? get phonetics => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;

  /// Serializes this IVocabDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IVocabDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IVocabDetailCopyWith<IVocabDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IVocabDetailCopyWith<$Res> {
  factory $IVocabDetailCopyWith(
    IVocabDetail value,
    $Res Function(IVocabDetail) then,
  ) = _$IVocabDetailCopyWithImpl<$Res, IVocabDetail>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? id,
    String? word,
    String? level,
    String? meaningVN,
    List<IDefinitions>? meanings,
    List<IPhonetic>? phonetics,
    String? topic,
  });
}

/// @nodoc
class _$IVocabDetailCopyWithImpl<$Res, $Val extends IVocabDetail>
    implements $IVocabDetailCopyWith<$Res> {
  _$IVocabDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IVocabDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? word = freezed,
    Object? level = freezed,
    Object? meaningVN = freezed,
    Object? meanings = freezed,
    Object? phonetics = freezed,
    Object? topic = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            word:
                freezed == word
                    ? _value.word
                    : word // ignore: cast_nullable_to_non_nullable
                        as String?,
            level:
                freezed == level
                    ? _value.level
                    : level // ignore: cast_nullable_to_non_nullable
                        as String?,
            meaningVN:
                freezed == meaningVN
                    ? _value.meaningVN
                    : meaningVN // ignore: cast_nullable_to_non_nullable
                        as String?,
            meanings:
                freezed == meanings
                    ? _value.meanings
                    : meanings // ignore: cast_nullable_to_non_nullable
                        as List<IDefinitions>?,
            phonetics:
                freezed == phonetics
                    ? _value.phonetics
                    : phonetics // ignore: cast_nullable_to_non_nullable
                        as List<IPhonetic>?,
            topic:
                freezed == topic
                    ? _value.topic
                    : topic // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IVocabDetailImplCopyWith<$Res>
    implements $IVocabDetailCopyWith<$Res> {
  factory _$$IVocabDetailImplCopyWith(
    _$IVocabDetailImpl value,
    $Res Function(_$IVocabDetailImpl) then,
  ) = __$$IVocabDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? id,
    String? word,
    String? level,
    String? meaningVN,
    List<IDefinitions>? meanings,
    List<IPhonetic>? phonetics,
    String? topic,
  });
}

/// @nodoc
class __$$IVocabDetailImplCopyWithImpl<$Res>
    extends _$IVocabDetailCopyWithImpl<$Res, _$IVocabDetailImpl>
    implements _$$IVocabDetailImplCopyWith<$Res> {
  __$$IVocabDetailImplCopyWithImpl(
    _$IVocabDetailImpl _value,
    $Res Function(_$IVocabDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IVocabDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? word = freezed,
    Object? level = freezed,
    Object? meaningVN = freezed,
    Object? meanings = freezed,
    Object? phonetics = freezed,
    Object? topic = freezed,
  }) {
    return _then(
      _$IVocabDetailImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        word:
            freezed == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                    as String?,
        level:
            freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                    as String?,
        meaningVN:
            freezed == meaningVN
                ? _value.meaningVN
                : meaningVN // ignore: cast_nullable_to_non_nullable
                    as String?,
        meanings:
            freezed == meanings
                ? _value._meanings
                : meanings // ignore: cast_nullable_to_non_nullable
                    as List<IDefinitions>?,
        phonetics:
            freezed == phonetics
                ? _value._phonetics
                : phonetics // ignore: cast_nullable_to_non_nullable
                    as List<IPhonetic>?,
        topic:
            freezed == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IVocabDetailImpl implements _IVocabDetail {
  const _$IVocabDetailImpl({
    @JsonKey(name: '_id') this.id,
    this.word,
    this.level,
    this.meaningVN,
    final List<IDefinitions>? meanings,
    final List<IPhonetic>? phonetics,
    this.topic,
  }) : _meanings = meanings,
       _phonetics = phonetics;

  factory _$IVocabDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$IVocabDetailImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? word;
  @override
  final String? level;
  @override
  final String? meaningVN;
  final List<IDefinitions>? _meanings;
  @override
  List<IDefinitions>? get meanings {
    final value = _meanings;
    if (value == null) return null;
    if (_meanings is EqualUnmodifiableListView) return _meanings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<IPhonetic>? _phonetics;
  @override
  List<IPhonetic>? get phonetics {
    final value = _phonetics;
    if (value == null) return null;
    if (_phonetics is EqualUnmodifiableListView) return _phonetics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? topic;

  @override
  String toString() {
    return 'IVocabDetail(id: $id, word: $word, level: $level, meaningVN: $meaningVN, meanings: $meanings, phonetics: $phonetics, topic: $topic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IVocabDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.meaningVN, meaningVN) ||
                other.meaningVN == meaningVN) &&
            const DeepCollectionEquality().equals(other._meanings, _meanings) &&
            const DeepCollectionEquality().equals(
              other._phonetics,
              _phonetics,
            ) &&
            (identical(other.topic, topic) || other.topic == topic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    word,
    level,
    meaningVN,
    const DeepCollectionEquality().hash(_meanings),
    const DeepCollectionEquality().hash(_phonetics),
    topic,
  );

  /// Create a copy of IVocabDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IVocabDetailImplCopyWith<_$IVocabDetailImpl> get copyWith =>
      __$$IVocabDetailImplCopyWithImpl<_$IVocabDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IVocabDetailImplToJson(this);
  }
}

abstract class _IVocabDetail implements IVocabDetail {
  const factory _IVocabDetail({
    @JsonKey(name: '_id') final String? id,
    final String? word,
    final String? level,
    final String? meaningVN,
    final List<IDefinitions>? meanings,
    final List<IPhonetic>? phonetics,
    final String? topic,
  }) = _$IVocabDetailImpl;

  factory _IVocabDetail.fromJson(Map<String, dynamic> json) =
      _$IVocabDetailImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get word;
  @override
  String? get level;
  @override
  String? get meaningVN;
  @override
  List<IDefinitions>? get meanings;
  @override
  List<IPhonetic>? get phonetics;
  @override
  String? get topic;

  /// Create a copy of IVocabDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IVocabDetailImplCopyWith<_$IVocabDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IPhonetic _$IPhoneticFromJson(Map<String, dynamic> json) {
  return _IPhonetic.fromJson(json);
}

/// @nodoc
mixin _$IPhonetic {
  String? get text => throw _privateConstructorUsedError;
  String? get audio => throw _privateConstructorUsedError;

  /// Serializes this IPhonetic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IPhonetic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IPhoneticCopyWith<IPhonetic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IPhoneticCopyWith<$Res> {
  factory $IPhoneticCopyWith(IPhonetic value, $Res Function(IPhonetic) then) =
      _$IPhoneticCopyWithImpl<$Res, IPhonetic>;
  @useResult
  $Res call({String? text, String? audio});
}

/// @nodoc
class _$IPhoneticCopyWithImpl<$Res, $Val extends IPhonetic>
    implements $IPhoneticCopyWith<$Res> {
  _$IPhoneticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IPhonetic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? audio = freezed}) {
    return _then(
      _value.copyWith(
            text:
                freezed == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String?,
            audio:
                freezed == audio
                    ? _value.audio
                    : audio // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IPhoneticImplCopyWith<$Res>
    implements $IPhoneticCopyWith<$Res> {
  factory _$$IPhoneticImplCopyWith(
    _$IPhoneticImpl value,
    $Res Function(_$IPhoneticImpl) then,
  ) = __$$IPhoneticImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, String? audio});
}

/// @nodoc
class __$$IPhoneticImplCopyWithImpl<$Res>
    extends _$IPhoneticCopyWithImpl<$Res, _$IPhoneticImpl>
    implements _$$IPhoneticImplCopyWith<$Res> {
  __$$IPhoneticImplCopyWithImpl(
    _$IPhoneticImpl _value,
    $Res Function(_$IPhoneticImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IPhonetic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? audio = freezed}) {
    return _then(
      _$IPhoneticImpl(
        text:
            freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String?,
        audio:
            freezed == audio
                ? _value.audio
                : audio // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IPhoneticImpl implements _IPhonetic {
  const _$IPhoneticImpl({this.text, this.audio});

  factory _$IPhoneticImpl.fromJson(Map<String, dynamic> json) =>
      _$$IPhoneticImplFromJson(json);

  @override
  final String? text;
  @override
  final String? audio;

  @override
  String toString() {
    return 'IPhonetic(text: $text, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IPhoneticImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.audio, audio) || other.audio == audio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, audio);

  /// Create a copy of IPhonetic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IPhoneticImplCopyWith<_$IPhoneticImpl> get copyWith =>
      __$$IPhoneticImplCopyWithImpl<_$IPhoneticImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IPhoneticImplToJson(this);
  }
}

abstract class _IPhonetic implements IPhonetic {
  const factory _IPhonetic({final String? text, final String? audio}) =
      _$IPhoneticImpl;

  factory _IPhonetic.fromJson(Map<String, dynamic> json) =
      _$IPhoneticImpl.fromJson;

  @override
  String? get text;
  @override
  String? get audio;

  /// Create a copy of IPhonetic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IPhoneticImplCopyWith<_$IPhoneticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IDefinitions _$IDefinitionsFromJson(Map<String, dynamic> json) {
  return _IDefinitions.fromJson(json);
}

/// @nodoc
mixin _$IDefinitions {
  String? get partOfSpeech => throw _privateConstructorUsedError;
  List<IDefinition>? get definitions => throw _privateConstructorUsedError;

  /// Serializes this IDefinitions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IDefinitions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IDefinitionsCopyWith<IDefinitions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IDefinitionsCopyWith<$Res> {
  factory $IDefinitionsCopyWith(
    IDefinitions value,
    $Res Function(IDefinitions) then,
  ) = _$IDefinitionsCopyWithImpl<$Res, IDefinitions>;
  @useResult
  $Res call({String? partOfSpeech, List<IDefinition>? definitions});
}

/// @nodoc
class _$IDefinitionsCopyWithImpl<$Res, $Val extends IDefinitions>
    implements $IDefinitionsCopyWith<$Res> {
  _$IDefinitionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IDefinitions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? partOfSpeech = freezed, Object? definitions = freezed}) {
    return _then(
      _value.copyWith(
            partOfSpeech:
                freezed == partOfSpeech
                    ? _value.partOfSpeech
                    : partOfSpeech // ignore: cast_nullable_to_non_nullable
                        as String?,
            definitions:
                freezed == definitions
                    ? _value.definitions
                    : definitions // ignore: cast_nullable_to_non_nullable
                        as List<IDefinition>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IDefinitionsImplCopyWith<$Res>
    implements $IDefinitionsCopyWith<$Res> {
  factory _$$IDefinitionsImplCopyWith(
    _$IDefinitionsImpl value,
    $Res Function(_$IDefinitionsImpl) then,
  ) = __$$IDefinitionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? partOfSpeech, List<IDefinition>? definitions});
}

/// @nodoc
class __$$IDefinitionsImplCopyWithImpl<$Res>
    extends _$IDefinitionsCopyWithImpl<$Res, _$IDefinitionsImpl>
    implements _$$IDefinitionsImplCopyWith<$Res> {
  __$$IDefinitionsImplCopyWithImpl(
    _$IDefinitionsImpl _value,
    $Res Function(_$IDefinitionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IDefinitions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? partOfSpeech = freezed, Object? definitions = freezed}) {
    return _then(
      _$IDefinitionsImpl(
        partOfSpeech:
            freezed == partOfSpeech
                ? _value.partOfSpeech
                : partOfSpeech // ignore: cast_nullable_to_non_nullable
                    as String?,
        definitions:
            freezed == definitions
                ? _value._definitions
                : definitions // ignore: cast_nullable_to_non_nullable
                    as List<IDefinition>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IDefinitionsImpl implements _IDefinitions {
  const _$IDefinitionsImpl({
    this.partOfSpeech,
    final List<IDefinition>? definitions,
  }) : _definitions = definitions;

  factory _$IDefinitionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IDefinitionsImplFromJson(json);

  @override
  final String? partOfSpeech;
  final List<IDefinition>? _definitions;
  @override
  List<IDefinition>? get definitions {
    final value = _definitions;
    if (value == null) return null;
    if (_definitions is EqualUnmodifiableListView) return _definitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'IDefinitions(partOfSpeech: $partOfSpeech, definitions: $definitions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IDefinitionsImpl &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                other.partOfSpeech == partOfSpeech) &&
            const DeepCollectionEquality().equals(
              other._definitions,
              _definitions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    partOfSpeech,
    const DeepCollectionEquality().hash(_definitions),
  );

  /// Create a copy of IDefinitions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IDefinitionsImplCopyWith<_$IDefinitionsImpl> get copyWith =>
      __$$IDefinitionsImplCopyWithImpl<_$IDefinitionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IDefinitionsImplToJson(this);
  }
}

abstract class _IDefinitions implements IDefinitions {
  const factory _IDefinitions({
    final String? partOfSpeech,
    final List<IDefinition>? definitions,
  }) = _$IDefinitionsImpl;

  factory _IDefinitions.fromJson(Map<String, dynamic> json) =
      _$IDefinitionsImpl.fromJson;

  @override
  String? get partOfSpeech;
  @override
  List<IDefinition>? get definitions;

  /// Create a copy of IDefinitions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IDefinitionsImplCopyWith<_$IDefinitionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IDefinition _$IDefinitionFromJson(Map<String, dynamic> json) {
  return _IDefinition.fromJson(json);
}

/// @nodoc
mixin _$IDefinition {
  String? get definition => throw _privateConstructorUsedError;
  String? get example => throw _privateConstructorUsedError;

  /// Serializes this IDefinition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IDefinitionCopyWith<IDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IDefinitionCopyWith<$Res> {
  factory $IDefinitionCopyWith(
    IDefinition value,
    $Res Function(IDefinition) then,
  ) = _$IDefinitionCopyWithImpl<$Res, IDefinition>;
  @useResult
  $Res call({String? definition, String? example});
}

/// @nodoc
class _$IDefinitionCopyWithImpl<$Res, $Val extends IDefinition>
    implements $IDefinitionCopyWith<$Res> {
  _$IDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? definition = freezed, Object? example = freezed}) {
    return _then(
      _value.copyWith(
            definition:
                freezed == definition
                    ? _value.definition
                    : definition // ignore: cast_nullable_to_non_nullable
                        as String?,
            example:
                freezed == example
                    ? _value.example
                    : example // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IDefinitionImplCopyWith<$Res>
    implements $IDefinitionCopyWith<$Res> {
  factory _$$IDefinitionImplCopyWith(
    _$IDefinitionImpl value,
    $Res Function(_$IDefinitionImpl) then,
  ) = __$$IDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? definition, String? example});
}

/// @nodoc
class __$$IDefinitionImplCopyWithImpl<$Res>
    extends _$IDefinitionCopyWithImpl<$Res, _$IDefinitionImpl>
    implements _$$IDefinitionImplCopyWith<$Res> {
  __$$IDefinitionImplCopyWithImpl(
    _$IDefinitionImpl _value,
    $Res Function(_$IDefinitionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? definition = freezed, Object? example = freezed}) {
    return _then(
      _$IDefinitionImpl(
        definition:
            freezed == definition
                ? _value.definition
                : definition // ignore: cast_nullable_to_non_nullable
                    as String?,
        example:
            freezed == example
                ? _value.example
                : example // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IDefinitionImpl implements _IDefinition {
  const _$IDefinitionImpl({this.definition, this.example});

  factory _$IDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IDefinitionImplFromJson(json);

  @override
  final String? definition;
  @override
  final String? example;

  @override
  String toString() {
    return 'IDefinition(definition: $definition, example: $example)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IDefinitionImpl &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.example, example) || other.example == example));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, definition, example);

  /// Create a copy of IDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IDefinitionImplCopyWith<_$IDefinitionImpl> get copyWith =>
      __$$IDefinitionImplCopyWithImpl<_$IDefinitionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IDefinitionImplToJson(this);
  }
}

abstract class _IDefinition implements IDefinition {
  const factory _IDefinition({
    final String? definition,
    final String? example,
  }) = _$IDefinitionImpl;

  factory _IDefinition.fromJson(Map<String, dynamic> json) =
      _$IDefinitionImpl.fromJson;

  @override
  String? get definition;
  @override
  String? get example;

  /// Create a copy of IDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IDefinitionImplCopyWith<_$IDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
