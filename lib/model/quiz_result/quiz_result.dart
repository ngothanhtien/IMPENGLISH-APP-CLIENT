import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learning_app_client/model/post/post.dart';

part 'quiz_result.freezed.dart';
part 'quiz_result.g.dart';

@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
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
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
@freezed
class QuestionQuizResult with _$QuestionQuizResult{
  const factory QuestionQuizResult({
    @JsonKey(name: "_id") String? id,
    String? questionId, // sửa lại nếu server trả questionId
    String? questionText,
    String? selectedAnswer,
    String? correctAnswer,
    bool? isCorrect,
  }) = _QuestionQuizResult;

  factory QuestionQuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuestionQuizResultFromJson(json);
}