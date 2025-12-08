import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/component/widgets/question_result_card.dart';
import 'package:learning_app_client/component/widgets/result_summary_card.dart';
import 'package:learning_app_client/component/widgets/stats_chart.dart';
import 'package:learning_app_client/model/quiz.dart';
import 'package:learning_app_client/model/quiz_result/quiz_result.dart';
import 'package:learning_app_client/service/quizResultService.dart';

class QuizResultsScreen extends StatefulWidget {
  final String quizResultId;
  final String timeLimit;

  const QuizResultsScreen({
    super.key,
    required this.quizResultId,
    required this.timeLimit,
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
  late Future<QuizResult> futureQuizResult;

  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    futureQuizResult = fetchDetailResultById();
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

  Future<QuizResult> fetchDetailResultById() async {
    try{
      final response = await quizResultService().getDetailQuizResultById(
          quizResultId: widget.quizResultId
      );
      if(response != null){
        return response;
      }else{
        throw Exception("Error at fetchDetailResultById!");
      }
    }catch(e){
      debugPrint("Error at fetchDetailResultById at screen_result: $e");
      rethrow;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuizResult>(
      future: futureQuizResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

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

        if(snapshot.hasData && snapshot.data != null){
          final quizResult = snapshot.data;

          final correct = quizResult?.correctAnswers ?? 0;
          final total = quizResult?.totalQuestions ?? 0;

          int allQuestion = total;
          int haftQuestion = allQuestion~/2;
          int questionBreakDownLenght = isExpandedResult ? allQuestion : haftQuestion;


          if (total > 0) {
            percentage = (correct / total) * 100;
          } else {
            percentage = 0; // hoặc null → tùy UI bạn muốn
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: const Color(0xFF4F46E5),
              title: const Text('Quiz Results',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.close,size: 22,color: Colors.white,),
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      // Celebration Header
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
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
                                size: 40,
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
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'You scored ${percentage}% in this quiz',
                              style: TextStyle(
                                fontSize: 14,
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
                        level: quizResult?.level ?? '',
                        category: quizResult?.category ?? '',
                        totalQuestions: quizResult?.totalQuestions ?? 0,
                        timeLimit: widget.timeLimit,
                        score: '${quizResult?.correctAnswers}/${quizResult?.totalQuestions}',
                        percentage: '${percentage.toInt()}%',
                        timeTaken: '5 min', // Mock data
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
                                correct: quizResult?.correctAnswers ?? 0,
                                incorrect: quizResult?.incorrectAnswers ?? 0,
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
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
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
                                    question: quizResult?.questions?[index].questionText ?? '',
                                    userAnswer: quizResult?.questions?[index].selectedAnswer ?? '',
                                    correctAnswer: quizResult?.questions?[index].correctAnswer ?? '',
                                    isCorrect: quizResult?.questions?[index].isCorrect ?? false,
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
                                    fontSize: 14,
                                    color: const Color(0xFF4F46E5)
                                ),
                              ),
                              Icon(isExpandedResult ? Icons.expand_less : Icons.expand_more,
                                size: 18,
                                color: const Color(0xFF4F46E5),
                              )
                            ],
                          )
                      ),
                      const SizedBox(height: 6),
                      // Action Buttons
                      Column(
                        children: [
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
                                  Icon(Icons.home, size: 22),
                                  SizedBox(width: 8),
                                  Text(
                                    'Back to Quiz Screen',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.2
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: TextButton(
                              onPressed: () => {
                                AppSnackBar.showInfo(context, 'Share functionality coming soon!')
                              },
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
                                        letterSpacing: -0.2
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
        return const Scaffold(
          body: Center(child: Text('No Quiz Result found')),
        );
      }
    );
  }
}
