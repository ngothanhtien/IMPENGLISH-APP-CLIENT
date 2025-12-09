// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizResultImpl _$$QuizResultImplFromJson(Map<String, dynamic> json) =>
    _$QuizResultImpl(
      id: json['_id'] as String?,
      userId:
          json['userId'] == null
              ? null
              : UserPost.fromJson(json['userId'] as Map<String, dynamic>),
      level: json['level'] as String?,
      category: json['category'] as String?,
      totalQuestions: (json['totalQuestions'] as num?)?.toInt(),
      correctAnswers: (json['correctAnswers'] as num?)?.toInt(),
      incorrectAnswers: (json['incorrectAnswers'] as num?)?.toInt(),
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map(
                (e) => QuestionQuizResult.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      statusFinish: json['statusFinish'] as bool?,
      completeAt:
          json['completeAt'] == null
              ? null
              : DateTime.parse(json['completeAt'] as String),
    );

Map<String, dynamic> _$$QuizResultImplToJson(_$QuizResultImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'level': instance.level,
      'category': instance.category,
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'incorrectAnswers': instance.incorrectAnswers,
      'questions': instance.questions,
      'statusFinish': instance.statusFinish,
      'completeAt': instance.completeAt?.toIso8601String(),
    };

_$QuestionQuizResultImpl _$$QuestionQuizResultImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionQuizResultImpl(
  id: json['_id'] as String?,
  questionId: json['questionId'] as String?,
  questionText: json['questionText'] as String?,
  selectedAnswer: json['selectedAnswer'] as String?,
  correctAnswer: json['correctAnswer'] as String?,
  isCorrect: json['isCorrect'] as bool?,
);

Map<String, dynamic> _$$QuestionQuizResultImplToJson(
  _$QuestionQuizResultImpl instance,
) => <String, dynamic>{
  '_id': instance.id,
  'questionId': instance.questionId,
  'questionText': instance.questionText,
  'selectedAnswer': instance.selectedAnswer,
  'correctAnswer': instance.correctAnswer,
  'isCorrect': instance.isCorrect,
};
