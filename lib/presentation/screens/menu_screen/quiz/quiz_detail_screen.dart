import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/quiz_detail_card.dart';
import 'package:learning_app_client/component/widgets/quiz_info_card.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_questions_screen.dart';

class QuizDetailScreen extends StatefulWidget {
  final String level;
  final String category;
  final String questions;
  final String timeLimit;

  const QuizDetailScreen({
    super.key,
    required this.level,
    required this.category,
    required this.questions,
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
            fontSize: 18,
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
            onPressed: () => _showFeatureComingSoon('Bookmark'),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined,size: 22,color: Colors.white),
            onPressed: () => _showFeatureComingSoon('Share'),
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
                                color: const Color(0xFF6366F1).withOpacity(0.3),
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
                        'Test your knowledge in ${widget.category} with ${widget.questions} exciting questions!',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF525E71),
                          fontWeight: FontWeight.w400,
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
                              value: widget.questions,
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
                        questions: widget.questions,
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
                    padding: const EdgeInsets.all(20),
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
              Icon(Icons.play_circle, color: Color(0xFF4F46E5), size: 32),
              SizedBox(width: 12),
              Text('Ready to Start?',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
              ),
            ],
          ),
          content: Text(
            'You\'re about to start a ${widget.level} ${widget.category} quiz with ${widget.questions} questions. You have ${widget.timeLimit} to complete it. Good luck!',
            style: TextStyle(
              letterSpacing: -0.2,
              fontSize: 14,
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
                context.push('/quiz/detail/practice',
                  extra: {
                    "level": widget.level,
                    "category": widget.category,
                    "questions": widget.questions,
                    "timeLimit": widget.timeLimit
                  }
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Start Now',
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

  void _showFeatureComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}