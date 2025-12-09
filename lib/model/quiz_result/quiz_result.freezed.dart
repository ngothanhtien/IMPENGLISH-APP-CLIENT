// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) {
  return _QuizResult.fromJson(json);
}

/// @nodoc
mixin _$QuizResult {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  UserPost? get userId => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  int? get totalQuestions => throw _privateConstructorUsedError;
  int? get correctAnswers => throw _privateConstructorUsedError;
  int? get incorrectAnswers => throw _privateConstructorUsedError;
  List<QuestionQuizResult>? get questions => throw _privateConstructorUsedError;
  bool? get statusFinish => throw _privateConstructorUsedError;
  DateTime? get completeAt => throw _privateConstructorUsedError;

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
    QuizResult value,
    $Res Function(QuizResult) then,
  ) = _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? id,
    UserPost? userId,
    String? level,
    String? category,
    int? totalQuestions,
    int? correctAnswers,
    int? incorrectAnswers,
    List<QuestionQuizResult>? questions,
    bool? statusFinish,
    DateTime? completeAt,
  });

  $UserPostCopyWith<$Res>? get userId;
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? level = freezed,
    Object? category = freezed,
    Object? totalQuestions = freezed,
    Object? correctAnswers = freezed,
    Object? incorrectAnswers = freezed,
    Object? questions = freezed,
    Object? statusFinish = freezed,
    Object? completeAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as UserPost?,
            level:
                freezed == level
                    ? _value.level
                    : level // ignore: cast_nullable_to_non_nullable
                        as String?,
            category:
                freezed == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String?,
            totalQuestions:
                freezed == totalQuestions
                    ? _value.totalQuestions
                    : totalQuestions // ignore: cast_nullable_to_non_nullable
                        as int?,
            correctAnswers:
                freezed == correctAnswers
                    ? _value.correctAnswers
                    : correctAnswers // ignore: cast_nullable_to_non_nullable
                        as int?,
            incorrectAnswers:
                freezed == incorrectAnswers
                    ? _value.incorrectAnswers
                    : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                        as int?,
            questions:
                freezed == questions
                    ? _value.questions
                    : questions // ignore: cast_nullable_to_non_nullable
                        as List<QuestionQuizResult>?,
            statusFinish:
                freezed == statusFinish
                    ? _value.statusFinish
                    : statusFinish // ignore: cast_nullable_to_non_nullable
                        as bool?,
            completeAt:
                freezed == completeAt
                    ? _value.completeAt
                    : completeAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuizResult
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
abstract class _$$QuizResultImplCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$QuizResultImplCopyWith(
    _$QuizResultImpl value,
    $Res Function(_$QuizResultImpl) then,
  ) = __$$QuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? id,
    UserPost? userId,
    String? level,
    String? category,
    int? totalQuestions,
    int? correctAnswers,
    int? incorrectAnswers,
    List<QuestionQuizResult>? questions,
    bool? statusFinish,
    DateTime? completeAt,
  });

  @override
  $UserPostCopyWith<$Res>? get userId;
}

/// @nodoc
class __$$QuizResultImplCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$QuizResultImpl>
    implements _$$QuizResultImplCopyWith<$Res> {
  __$$QuizResultImplCopyWithImpl(
    _$QuizResultImpl _value,
    $Res Function(_$QuizResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? level = freezed,
    Object? category = freezed,
    Object? totalQuestions = freezed,
    Object? correctAnswers = freezed,
    Object? incorrectAnswers = freezed,
    Object? questions = freezed,
    Object? statusFinish = freezed,
    Object? completeAt = freezed,
  }) {
    return _then(
      _$QuizResultImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as UserPost?,
        level:
            freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                    as String?,
        category:
            freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String?,
        totalQuestions:
            freezed == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                    as int?,
        correctAnswers:
            freezed == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                    as int?,
        incorrectAnswers:
            freezed == incorrectAnswers
                ? _value.incorrectAnswers
                : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                    as int?,
        questions:
            freezed == questions
                ? _value._questions
                : questions // ignore: cast_nullable_to_non_nullable
                    as List<QuestionQuizResult>?,
        statusFinish:
            freezed == statusFinish
                ? _value.statusFinish
                : statusFinish // ignore: cast_nullable_to_non_nullable
                    as bool?,
        completeAt:
            freezed == completeAt
                ? _value.completeAt
                : completeAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizResultImpl implements _QuizResult {
  const _$QuizResultImpl({
    @JsonKey(name: "_id") this.id,
    this.userId,
    this.level,
    this.category,
    this.totalQuestions,
    this.correctAnswers,
    this.incorrectAnswers,
    final List<QuestionQuizResult>? questions,
    this.statusFinish,
    this.completeAt,
  }) : _questions = questions;

  factory _$QuizResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizResultImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
  @override
  final UserPost? userId;
  @override
  final String? level;
  @override
  final String? category;
  @override
  final int? totalQuestions;
  @override
  final int? correctAnswers;
  @override
  final int? incorrectAnswers;
  final List<QuestionQuizResult>? _questions;
  @override
  List<QuestionQuizResult>? get questions {
    final value = _questions;
    if (value == null) return null;
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? statusFinish;
  @override
  final DateTime? completeAt;

  @override
  String toString() {
    return 'QuizResult(id: $id, userId: $userId, level: $level, category: $category, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, questions: $questions, statusFinish: $statusFinish, completeAt: $completeAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.incorrectAnswers, incorrectAnswers) ||
                other.incorrectAnswers == incorrectAnswers) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.statusFinish, statusFinish) ||
                other.statusFinish == statusFinish) &&
            (identical(other.completeAt, completeAt) ||
                other.completeAt == completeAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    level,
    category,
    totalQuestions,
    correctAnswers,
    incorrectAnswers,
    const DeepCollectionEquality().hash(_questions),
    statusFinish,
    completeAt,
  );

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      __$$QuizResultImplCopyWithImpl<_$QuizResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizResultImplToJson(this);
  }
}

abstract class _QuizResult implements QuizResult {
  const factory _QuizResult({
    @JsonKey(name: "_id") final String? id,
    final UserPost? userId,
    final String? level,
    final String? category,
    final int? totalQuestions,
    final int? correctAnswers,
    final int? incorrectAnswers,
    final List<QuestionQuizResult>? questions,
    final bool? statusFinish,
    final DateTime? completeAt,
  }) = _$QuizResultImpl;

  factory _QuizResult.fromJson(Map<String, dynamic> json) =
      _$QuizResultImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
  @override
  UserPost? get userId;
  @override
  String? get level;
  @override
  String? get category;
  @override
  int? get totalQuestions;
  @override
  int? get correctAnswers;
  @override
  int? get incorrectAnswers;
  @override
  List<QuestionQuizResult>? get questions;
  @override
  bool? get statusFinish;
  @override
  DateTime? get completeAt;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestionQuizResult _$QuestionQuizResultFromJson(Map<String, dynamic> json) {
  return _QuestionQuizResult.fromJson(json);
}

/// @nodoc
mixin _$QuestionQuizResult {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  String? get questionId =>
      throw _privateConstructorUsedError; // sửa lại nếu server trả questionId
  String? get questionText => throw _privateConstructorUsedError;
  String? get selectedAnswer => throw _privateConstructorUsedError;
  String? get correctAnswer => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this QuestionQuizResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionQuizResultCopyWith<QuestionQuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionQuizResultCopyWith<$Res> {
  factory $QuestionQuizResultCopyWith(
    QuestionQuizResult value,
    $Res Function(QuestionQuizResult) then,
  ) = _$QuestionQuizResultCopyWithImpl<$Res, QuestionQuizResult>;
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? id,
    String? questionId,
    String? questionText,
    String? selectedAnswer,
    String? correctAnswer,
    bool? isCorrect,
  });
}

/// @nodoc
class _$QuestionQuizResultCopyWithImpl<$Res, $Val extends QuestionQuizResult>
    implements $QuestionQuizResultCopyWith<$Res> {
  _$QuestionQuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? questionId = freezed,
    Object? questionText = freezed,
    Object? selectedAnswer = freezed,
    Object? correctAnswer = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            questionId:
                freezed == questionId
                    ? _value.questionId
                    : questionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            questionText:
                freezed == questionText
                    ? _value.questionText
                    : questionText // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedAnswer:
                freezed == selectedAnswer
                    ? _value.selectedAnswer
                    : selectedAnswer // ignore: cast_nullable_to_non_nullable
                        as String?,
            correctAnswer:
                freezed == correctAnswer
                    ? _value.correctAnswer
                    : correctAnswer // ignore: cast_nullable_to_non_nullable
                        as String?,
            isCorrect:
                freezed == isCorrect
                    ? _value.isCorrect
                    : isCorrect // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionQuizResultImplCopyWith<$Res>
    implements $QuestionQuizResultCopyWith<$Res> {
  factory _$$QuestionQuizResultImplCopyWith(
    _$QuestionQuizResultImpl value,
    $Res Function(_$QuestionQuizResultImpl) then,
  ) = __$$QuestionQuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "_id") String? id,
    String? questionId,
    String? questionText,
    String? selectedAnswer,
    String? correctAnswer,
    bool? isCorrect,
  });
}

/// @nodoc
class __$$QuestionQuizResultImplCopyWithImpl<$Res>
    extends _$QuestionQuizResultCopyWithImpl<$Res, _$QuestionQuizResultImpl>
    implements _$$QuestionQuizResultImplCopyWith<$Res> {
  __$$QuestionQuizResultImplCopyWithImpl(
    _$QuestionQuizResultImpl _value,
    $Res Function(_$QuestionQuizResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? questionId = freezed,
    Object? questionText = freezed,
    Object? selectedAnswer = freezed,
    Object? correctAnswer = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _$QuestionQuizResultImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        questionId:
            freezed == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        questionText:
            freezed == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedAnswer:
            freezed == selectedAnswer
                ? _value.selectedAnswer
                : selectedAnswer // ignore: cast_nullable_to_non_nullable
                    as String?,
        correctAnswer:
            freezed == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                    as String?,
        isCorrect:
            freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionQuizResultImpl implements _QuestionQuizResult {
  const _$QuestionQuizResultImpl({
    @JsonKey(name: "_id") this.id,
    this.questionId,
    this.questionText,
    this.selectedAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory _$QuestionQuizResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionQuizResultImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
  @override
  final String? questionId;
  // sửa lại nếu server trả questionId
  @override
  final String? questionText;
  @override
  final String? selectedAnswer;
  @override
  final String? correctAnswer;
  @override
  final bool? isCorrect;

  @override
  String toString() {
    return 'QuestionQuizResult(id: $id, questionId: $questionId, questionText: $questionText, selectedAnswer: $selectedAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionQuizResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    questionId,
    questionText,
    selectedAnswer,
    correctAnswer,
    isCorrect,
  );

  /// Create a copy of QuestionQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionQuizResultImplCopyWith<_$QuestionQuizResultImpl> get copyWith =>
      __$$QuestionQuizResultImplCopyWithImpl<_$QuestionQuizResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionQuizResultImplToJson(this);
  }
}

abstract class _QuestionQuizResult implements QuestionQuizResult {
  const factory _QuestionQuizResult({
    @JsonKey(name: "_id") final String? id,
    final String? questionId,
    final String? questionText,
    final String? selectedAnswer,
    final String? correctAnswer,
    final bool? isCorrect,
  }) = _$QuestionQuizResultImpl;

  factory _QuestionQuizResult.fromJson(Map<String, dynamic> json) =
      _$QuestionQuizResultImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
  @override
  String? get questionId; // sửa lại nếu server trả questionId
  @override
  String? get questionText;
  @override
  String? get selectedAnswer;
  @override
  String? get correctAnswer;
  @override
  bool? get isCorrect;

  /// Create a copy of QuestionQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionQuizResultImplCopyWith<_$QuestionQuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
