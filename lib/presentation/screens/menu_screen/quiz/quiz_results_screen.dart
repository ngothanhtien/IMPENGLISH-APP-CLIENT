import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/question_result_card.dart';
import 'package:learning_app_client/component/widgets/result_summary_card.dart';
import 'package:learning_app_client/component/widgets/stats_chart.dart';
import 'package:learning_app_client/model/quiz.dart';
import 'package:learning_app_client/model/quiz_question.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_questions_screen.dart';
import 'quiz_screen.dart';

class QuizResultsScreen extends StatefulWidget {
  final String level;
  final String category;
  final String questions;
  final String timeLimit;
  final List<String> userAnswers;
  final List<Question> quizQuestions;

  const QuizResultsScreen({
    super.key,
    required this.level,
    required this.category,
    required this.questions,
    required this.timeLimit,
    required this.userAnswers,
    required this.quizQuestions,
  });

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _statsAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _statsAnimation;
  bool isExpandedResult = false;

  int correctAnswers = 0;
  int incorrectAnswers = 0;
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _calculateResults();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 0.3,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _statsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _statsAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _statsAnimationController.forward();
      }
    });
  }

  void _calculateResults() {
    correctAnswers = 0;
    for (int i = 0; i < widget.userAnswers.length; i++) {
      if (widget.userAnswers[i] == widget.quizQuestions[i].correctAnswer) {
        correctAnswers++;
      }
    }
    incorrectAnswers = widget.userAnswers.length - correctAnswers;
    percentage = (correctAnswers / widget.userAnswers.length) * 100;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int allQuestion = widget.quizQuestions.length;
    int haftQuestion = allQuestion~/2;
    int questionBreakDownLenght = isExpandedResult ? allQuestion : haftQuestion;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text('Quiz Results',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close,size: 30,color: Colors.white,),
          onPressed: () => context.go('/quiz'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color(0xFFE2E8F0),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Transform.translate(
          offset: Offset(0, _slideAnimation.value * 50),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Celebration Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: percentage >= 70
                                ? [const Color(0xFF10B981), const Color(0xFF059669)]
                                : percentage >= 50
                                ? [const Color(0xFFF59E0B), const Color(0xFFD97706)]
                                : [const Color(0xFFEF4444), const Color(0xFFDC2626)],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: (percentage >= 70
                                  ? const Color(0xFF10B981)
                                  : percentage >= 50
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFFEF4444))
                                  .withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          percentage >= 70
                              ? Icons.emoji_events
                              : percentage >= 50
                              ? Icons.thumb_up
                              : Icons.refresh,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        percentage >= 70
                            ? 'Excellent!'
                            : percentage >= 50
                            ? 'Good Job!'
                            : 'Keep Trying!',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You scored ${percentage.toInt()}% in this quiz',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Results Summary
                ResultSummaryCard(
                  level: widget.level,
                  category: widget.category,
                  questions: widget.questions,
                  timeLimit: widget.timeLimit,
                  score: '$correctAnswers/${widget.userAnswers.length}',
                  percentage: '${percentage.toInt()}%',
                  timeTaken: '8 min', // Mock data
                ),
                const SizedBox(height: 24),

                // Statistics Chart
                AnimatedBuilder(
                  animation: _statsAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _statsAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - _statsAnimation.value) * 30),
                        child: StatsChart(
                          correct: correctAnswers,
                          incorrect: incorrectAnswers,
                          animation: _statsAnimation,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Question Breakdown
                const Text(
                  'Question Breakdown',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 16),

                ...List.generate(
                  questionBreakDownLenght,
                      (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnimatedBuilder(
                      animation: _statsAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _statsAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - _statsAnimation.value) * 20),
                            child: QuestionResultCard(
                              questionNumber: index + 1,
                              question: widget.quizQuestions[index].questionText.toString(),
                              userAnswer: widget.userAnswers[index],
                              correctAnswer: widget.quizQuestions[index].correctAnswer.toString(),
                              isCorrect: widget.userAnswers[index] ==
                                  widget.quizQuestions[index].correctAnswer,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                TextButton(
                    onPressed: (){
                      setState(() {
                        isExpandedResult = !isExpandedResult;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isExpandedResult ? "Show less": "Show More",
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color(0xFF4F46E5)
                          ),
                        ),
                        Icon(isExpandedResult ? Icons.expand_less : Icons.expand_more,
                          size: 20,
                          color: const Color(0xFF4F46E5),
                        )
                      ],
                    )
                ),
                const SizedBox(height: 20),
                // Action Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _retryQuiz(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Retry Quiz',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => context.go('/quiz'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4F46E5),
                          side: const BorderSide(
                            color: const Color(0xFF4F46E5),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Back to Quiz Screen',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        onPressed: () => _shareResults(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Share Results',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _retryQuiz() {
    context.go('/quiz/detail/practice',
        extra: {
          "level": widget.level,
          "category": widget.category,
          "questions": widget.questions,
          "timeLimit": widget.timeLimit
        }
    );
  }

  void _shareResults() {
    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon!'),
        backgroundColor: Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
