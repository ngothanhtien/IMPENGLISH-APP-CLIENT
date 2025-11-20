import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/countdown_timer/countdown_timer.dart';
import 'package:learning_app_client/component/widgets/progress_indicator_widget.dart';
import 'package:learning_app_client/component/widgets/question_card.dart';
import 'package:learning_app_client/model/quiz.dart';
import 'package:learning_app_client/service/quizService.dart';
import 'dart:math';

class QuizQuestionsScreen extends StatefulWidget {
  final String level;
  final String category;
  final String questions;
  final String timeLimit;

  const QuizQuestionsScreen({
    super.key,
    required this.level,
    required this.category,
    required this.questions,
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

  late Future<List<Question>> futureQuestions;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    futureQuestions = _generateQuestions();
  }

  Future<List<Question>> _generateQuestions() async {
    try {
      final quiz = await quizService().fetchQuiz(
        level: widget.level,
        topic: widget.category,
        numberQuestions: int.parse(widget.questions),
      );

      if (quiz.data != null && quiz.data!.isNotEmpty) {
        final questions = quiz.data!.first.question;
        userAnswers = List.filled(questions!.length, '');
        return questions!;
      } else {
        throw Exception("Error: Can't fetch data quiz!");
      }
    } catch (e) {
      debugPrint("Error at _generateQuestions: $e");
      rethrow;
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
            _finishQuiz(_cachedQuestions);
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

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
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
          _finishQuiz(_cachedQuestions);
        });
      }
    });
  }

  void _finishQuiz(List<Question> questions) {
    context.push(
      '/quiz/detail/practice/result',
      extra: {
        "level": widget.level,
        "category": widget.category,
        "questions": widget.questions,
        "timeLimit": widget.timeLimit,
        "userAnswers": userAnswers,
        "quizQuestions": questions,
      },
    );
  }

  void _showDialogTimeOut(List<Question> questions) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(Icons.check_circle, size: 32, color: Color(0xFF4F46E5)),
              SizedBox(width: 12),
              Text(
                "Time is up",
                style: TextStyle(
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          content: const Text(
            "Time is up. Please press 'Finish' to see results",
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.pop();
                _finishQuiz(questions);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Finish', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
  void _showDialogCancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.close, color: Color(0xFF4F46E5), size: 24),
              SizedBox(width: 12),
              Text('Exit Quiz?',style: TextStyle(fontWeight: FontWeight.w700,
              color: Color(0xFF4F46E5),fontSize: 18
              ),),
            ],
          ),
          content: Text(
            'Do you really want to get out of the Quiz?',
            style: TextStyle(
                letterSpacing: -0.2,
                fontSize: 15,
                height: 1.5
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ],
        );
      },
    );
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

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: const Color(0xFF4F46E5),
              title: Text(
                'Quiz in ${widget.category} - Level: ${widget.level}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5
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
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
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
                                  fontSize: 16,
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
