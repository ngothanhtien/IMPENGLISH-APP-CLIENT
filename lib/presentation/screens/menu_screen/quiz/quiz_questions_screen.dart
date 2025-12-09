import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/countdown_timer/countdown_timer.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/alertdialog_custom.dart';
import 'package:learning_app_client/component/widgets/progress_indicator_widget.dart';
import 'package:learning_app_client/component/widgets/question_card.dart';
import 'package:learning_app_client/model/quiz.dart';
import 'package:learning_app_client/model/quiz_result/quiz_result.dart';
import 'package:learning_app_client/service/quiz_result_service.dart';
import 'package:learning_app_client/service/quiz_service.dart';
import 'dart:math';

class QuizQuestionsScreen extends StatefulWidget {
  final String level;
  final String category;
  final int totalQuestions;
  final String timeLimit;

  const QuizQuestionsScreen({
    super.key,
    required this.level,
    required this.category,
    required this.totalQuestions,
    required this.timeLimit,
  });

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _cardFlipAnimation;
  bool _isAnimating = false;
  bool _hasSwapped = false;
  bool _shouldFinishAfterAnimation = false;

  int? _currentQuestionsLength;
  int currentQuestionIndex = 0;
  List<String> userAnswers = [];
  String? selectedAnswer;
  bool isAnswerSelected = false;
  List<Question> _cachedQuestions = [];

  //operator for create result
  int totalQuestions = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  List<QuestionQuizResult> questionsQuizResult = [];
  DateTime completeAt = DateTime.now();

  late Future<List<Question>> futureQuestions;

  Future<List<Question>> _generateQuestions() async {
    try {
      final quiz = await QuizService().fetchQuiz(
        level: widget.level,
        topic: widget.category,
        numberQuestions: widget.totalQuestions,
      );

      if (quiz.data != null && quiz.data!.isNotEmpty) {
        final questions = quiz.data!.first.question;
        userAnswers = List.filled(questions!.length, '');
        return questions;
      } else {
        throw Exception("Error: Can't fetch data quiz!");
      }
    } catch (e) {
      debugPrint("Error at _generateQuestions: $e");
      rethrow;
    }
  }
  Future<String?> createQuizResult() async {
    _calculateResults();
    _generateQuestionQuizResult();
    try{
      final quizResult = QuizResult(
        level: widget.level,
        category: widget.category,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
        incorrectAnswers: incorrectAnswers,
        statusFinish: true,
        questions: questionsQuizResult,
      );

      final response = await QuizResultService().createQuizResult(
        quiz: quizResult,
        userId: '68cd5981cf94a9641d3e9391',
      );

      if (!mounted) return null;

      if (response['status'] == 'Success') {
        final data = response['data'];
        final id = data?['_id'] as String?;

        if (id != null) {
          AppSnackBar.showSuccess(context, "Submit quiz successfully");
          return id;
        }
        return null;
      } else {
        throw Exception("Submit failed: ${response['message'] ?? 'Unknown'}");
      }
    }catch(e){
      debugPrint("Error at createQuizResult: $e");
      rethrow;
    }
  }

  Future<void> _finishQuiz(List<Question> questions) async {
    String? quizResultId;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
    try {
      quizResultId = await createQuizResult();
      if(!mounted) return;
    } catch (e) {
      if (mounted) context.pop();
      AppSnackBar.showError(context, "Submit quiz fail: $e");
      return;
    }

    if (mounted) Navigator.of(context).pop();

    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      context.push(
        '/quiz/detail/practice/result',
        extra: {
          "quizResultId": quizResultId,
          "timeLimit": widget.timeLimit,
        },
      );
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _cardFlipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeInOut),
    );

    // Swap nội dung một lần khi animation đi qua giữa (>= 0.5)
    _cardFlipAnimation.addListener(() {
      final v = _cardFlipAnimation.value;
      if (v >= 0.5 && !_hasSwapped) {
        setState(() {
          if (currentQuestionIndex < (_currentQuestionsLength ?? 0) - 1) {
            currentQuestionIndex++;
            selectedAnswer = userAnswers[currentQuestionIndex].isEmpty
                ? null
                : userAnswers[currentQuestionIndex];
            isAnswerSelected = userAnswers[currentQuestionIndex].isNotEmpty;
          } else {
            _shouldFinishAfterAnimation = true;
          }
        });
        _hasSwapped = true;
      }
    });

    // Listen status: khi forward xong -> tự reverse; khi reverse xong (dismissed) -> reset / finish
    _cardAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // forward finished -> reverse back
        _cardAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // whole flip cycle finished
        if (_shouldFinishAfterAnimation) {
          // gọi finish sau frame để tránh gọi khi đang trong quá trình render
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSubmitQuiz(_cachedQuestions);
          });
        }
        // reset flags
        _isAnimating = false;
        _hasSwapped = false;
        _shouldFinishAfterAnimation = false;
      }
    });

    _animationController.forward();
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isAnswerSelected = true;
      userAnswers[currentQuestionIndex] = answer;
    });
  }

  void _nextQuestion(List<Question> questions) {
    if (!isAnswerSelected) return;

    _cachedQuestions = questions;
    _currentQuestionsLength = questions.length;

    // reset trạng thái xoay
    _hasSwapped = false;
    _shouldFinishAfterAnimation = false;

    // chạy animation xoay 1 chiều
    _cardAnimationController.forward(from: 0).then((_) {
      // khi xoay xong hết (value = 1)
      _cardAnimationController.reset();

      // nếu là câu cuối, hoàn thành quiz
      if (_shouldFinishAfterAnimation) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSubmitQuiz(_cachedQuestions);
        });
      }
    });
  }

  void _calculateResults(){
    final questionTemp = _cachedQuestions;
    final answers = userAnswers;
    final len = min(answers.length, questionTemp.length);

    totalQuestions = len;
    correctAnswers = 0;
    for (int i = 0; i < len; i++) {
      if (answers[i] == questionTemp[i].correctAnswer) {
        correctAnswers++;
      }
    }
    incorrectAnswers = len - correctAnswers;
  }

  void _generateQuestionQuizResult(){
    questionsQuizResult.clear();
    final questionTemp = _cachedQuestions;
    final answers = userAnswers;

    final len = min(answers.length, questionTemp.length);
    for(int i = 0; i < len; i++){
      final selected = answers[i].isEmpty ? 'No answer' : answers[i];
      final q = questionTemp[i];
      final result = QuestionQuizResult(
        id: null,
        questionId: q.qsId,
        questionText: q.questionText,
        selectedAnswer: selected,
        correctAnswer: q.correctAnswer,
        isCorrect: q.correctAnswer == answers[i],
      );
      questionsQuizResult.add(result);
    }
  }

  void _showDialogTimeOut(List<Question> questions) {
    showAppDialog(
      context,
      icon: Icons.timer_outlined,
      title: "Time is up",
      message: "Time is up. Please press (Finish) to end the quiz.",
      okText: "Finish",
      onOk: (){_finishQuiz(questions);},
      animType: AnimType.scale,
      primaryColor: Colors.deepOrange,
      dismissOntouchOnside: false,
      align: TextAlign.center,
      hideBtnCancel: true
    );
  }

  void _showSubmitQuiz(List<Question> questions) {
    showAppDialog(
      context,
      icon: Icons.check_circle,
      title: "Confirm Submit",
      message: "Do you really want to Submit the Quiz?",
      okText: "Submit",
      onOk: (){_finishQuiz(questions);},
      animType: AnimType.scale,
      align: TextAlign.center,
      primaryColor: Colors.green,
      titleColor: Colors.green
    );
  }

  void _showDialogCancel() {
    showAppDialog(
      context,
      icon: Icons.logout_rounded,
      title: "Exit Quiz?",
      message: "Do you really want to exit the quiz?",
      okText: "Exit",
      onOk: (){context.pop();},
      animType: AnimType.scale,
      primaryColor: Colors.redAccent,
      titleColor: Colors.redAccent
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    futureQuestions = _generateQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: futureQuestions,
      builder: (context, snapshot) {
        /// 🕓 Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// ❌ Error state
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          );
        }

        /// ✅ Success state
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final questions = snapshot.data!;
          final currentQuestion = questions[currentQuestionIndex];
          final progress = (currentQuestionIndex) / questions.length;
          final timesplit = widget.timeLimit.split(" ");
          int timePractice = widget.timeLimit != 'None'
              ? int.parse(timesplit[0])
              : 0;
          _cachedQuestions = questions;
          _currentQuestionsLength ??= questions.length;

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: const Color(0xFF4F46E5),
              title: Text(
                'Quiz in ${widget.category} - Level: ${widget.level}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -1
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                onPressed: _showDialogCancel,
              ),
            ),
            body: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        widget.timeLimit != 'None'
                            ? CountdownTimerWidget(
                          minutes: timePractice,
                          onComplete: () => _showDialogTimeOut(questions),
                          size: 60,
                        )
                            : const Text(
                          "Don't limit time",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${currentQuestionIndex + 1} of ${questions.length}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF374151),
                                height: 1.5
                              ),
                            ),
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ProgressIndicatorWidget(progress: progress),
                      ],
                    ),
                  ),

                  // 🧠 Question Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedBuilder(
                        animation: _cardFlipAnimation,
                        builder: (context, child) {
                          final angle = _cardFlipAnimation.value * pi; // 0 -> pi (0..180°)
                          final isUnder = angle > (pi / 2);

                          final displayedChild = QuestionCard(
                            question: currentQuestion, // currentQuestion được cập nhật bởi listener
                            selectedAnswer: selectedAnswer,
                            onAnswerSelected: _selectAnswer,
                          );

                          final childToShow = isUnder
                              ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: displayedChild,
                          )
                              : displayedChild;

                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(angle),
                            child: childToShow,
                          );
                        },
                      ),
                    ),
                  ),

                  // 👉 Next Button Section
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: (currentQuestionIndex > 0) ? (){
                                  setState(() {
                                    currentQuestionIndex--;
                                    selectedAnswer = userAnswers[currentQuestionIndex].isEmpty ? null : userAnswers[currentQuestionIndex];
                                    isAnswerSelected = userAnswers[currentQuestionIndex].isNotEmpty;
                                  });
                                } : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentQuestionIndex > 0
                                      ? const Color(0xFF4F46E5)
                                      : Colors.grey[300],
                                  foregroundColor: currentQuestionIndex > 0
                                      ? Colors.white
                                      : Colors.grey[500],
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Previous',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: (isAnswerSelected && !_isAnimating)
                                    ? () => _nextQuestion(questions)
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAnswerSelected
                                      ? const Color(0xFF4F46E5)
                                      : Colors.grey[300],
                                  foregroundColor: isAnswerSelected
                                      ? Colors.white
                                      : Colors.grey[500],
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentQuestionIndex == questions.length - 1
                                          ? 'Finish Quiz'
                                          : 'Next Question',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      currentQuestionIndex == questions.length - 1
                                          ? Icons.check_circle
                                          : Icons.arrow_forward,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        /// Empty fallback
        return const Scaffold(
          body: Center(child: Text('No questions found')),
        );
      },
    );
  }
}
