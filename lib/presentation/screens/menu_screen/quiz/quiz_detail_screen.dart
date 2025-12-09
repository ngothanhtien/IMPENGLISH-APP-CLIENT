import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/alertdialog_custom.dart';
import 'package:learning_app_client/component/widgets/quiz_detail_card.dart';
import 'package:learning_app_client/component/widgets/quiz_info_card.dart';

class QuizDetailScreen extends StatefulWidget {
  final String level;
  final String category;
  final int totalQuestions;
  final String timeLimit;

  const QuizDetailScreen({
    super.key,
    required this.level,
    required this.category,
    required this.totalQuestions,
    required this.timeLimit,
  });

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Main content animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Button animation (delayed)
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations with delay
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _buttonAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title:  Text('Quiz Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: -0.5
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,size: 22,color: Colors.white,),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline,size: 22,color: Colors.white),
            onPressed: () => {
              AppSnackBar.showInfo(context, "Bookmark feature comming soon")
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined,size: 22,color: Colors.white),
            onPressed: () => {
              AppSnackBar.showInfo(context, "Share feature comming soon")
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quiz illustration
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF6366F1),
                                Color(0xFF4F46E5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.quiz,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Quiz title
                      const Text(
                        'Your Quiz is Ready!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      Text(
                        'Test your knowledge in ${widget.category} with ${widget.totalQuestions} exciting questions!',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF4C525A),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                          height: 1.5
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 32),

                      // Quiz Summary Section
                      const Text(
                        'Quiz Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Quiz details grid
                      Row(
                        children: [
                          Expanded(
                            child: QuizDetailCard(
                              icon: Icons.trending_up,
                              label: 'Level',
                              value: widget.level,
                              color: _getLevelColor(widget.level),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: QuizDetailCard(
                              icon: Icons.category,
                              label: 'Category',
                              value: widget.category,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: QuizDetailCard(
                              icon: Icons.quiz,
                              label: 'Questions',
                              value: widget.totalQuestions.toString(),
                              color: const Color(0xFF8B5CF6),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: QuizDetailCard(
                              icon: Icons.timer,
                              label: 'Time Limit',
                              value: widget.timeLimit,
                              color: const Color(0xFFF59E0B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Quiz Information Card
                      QuizInfoCard(
                        category: widget.category,
                        level: widget.level,
                        questions: widget.totalQuestions.toString(),
                        timeLimit: widget.timeLimit,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Action buttons
              FadeTransition(
                opacity: _buttonFadeAnimation,
                child: SlideTransition(
                  position: _buttonSlideAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                      child: Column(
                        children: [
                          // Start Quiz Button
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _startQuiz(),
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
                                  Icon(Icons.play_arrow, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'Start Quiz',
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

                          // Edit Filters Button
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () => context.pop(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF6366F1),
                                side: const BorderSide(
                                  color: Color(0xFF6366F1),
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Edit Filters',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'Easy':
        return const Color(0xFF10B981);
      case 'Medium':
        return const Color(0xFFF59E0B);
      case 'Hard':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6366F1);
    }
  }

  void _startQuiz() {
    showAppDialog(
      context,
      icon: Icons.play_circle,
      title: 'Ready to Start?',
      message: 'You\'re about to start a ${widget.level} ${widget.category} '
          'quiz with ${widget.totalQuestions} questions. You have ${widget.timeLimit} '
          'to complete it. Good luck!',
      onOk: (){
        context.pop();
        context.push('/quiz/detail/practice',
            extra: {
              "level": widget.level,
              "category": widget.category,
              "totalQuestions": widget.totalQuestions,
              "timeLimit": widget.timeLimit
            }
        );
      },
      animType: AnimType.scale,
      okText: "Start Now",
      align: TextAlign.justify
    );
  }
}