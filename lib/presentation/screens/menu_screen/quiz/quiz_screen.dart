import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/filter_chip_widget.dart';
import 'package:learning_app_client/component/widgets/filter_dropdown.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_detail_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String selectedLevel = 'Easy';
  String selectedCategory = 'Technology';
  String selectedQuestions = '5';
  String selectedTime = '1 min';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text('Create Quiz',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),
        leading: IconButton(
            onPressed: () => context.go("/home"),
            icon: Icon(Icons.arrow_back,size: 22,color: Colors.white,)
        ),
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
                        // Header illustration
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Icon(
                              Icons.quiz,
                              size: 40,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Filters Section
                        const Text(
                          'Customize Your Quiz',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Set your preferences to create the perfect quiz experience',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Level Filter
                        _buildFilterSection(
                          'Difficulty Level',
                          FilterChipWidget(
                            options: const ['Easy', 'Medium', 'Hard'],
                            selectedOption: selectedLevel,
                            onSelected: (value) => setState(() => selectedLevel = value),
                          ),
                        ),

                        // Category Filter
                        _buildFilterSection(
                          'Category',
                          FilterDropdown(
                            value: selectedCategory,
                            options: const [
                              'Technology',
                              'Business',
                              'Education',
                              'Sports',
                              'Entertainment',
                              'Science',
                              'History',
                            ],
                            onChanged: (value) => setState(() => selectedCategory = value!),
                          ),
                        ),

                        // Number of Questions
                        _buildFilterSection(
                          'Number of Questions',
                          FilterChipWidget(
                            options: const ['5', '10', '20'],
                            selectedOption: selectedQuestions,
                            onSelected: (value) => setState(() => selectedQuestions = value),
                          ),
                        ),

                        // Time Limit
                        _buildFilterSection(
                          'Time Limit',
                          FilterChipWidget(
                            options: const ['1 min','5 min', '10 min', '20 min',"None"],
                            selectedOption: selectedTime,
                            onSelected: (value) => setState(() => selectedTime = value),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SafeArea(
                          child: SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton.icon(
                              onPressed:()=> context.push("/quiz/detail",
                                extra: {
                                  "level": selectedLevel,
                                  "category": selectedCategory,
                                  "questions": selectedQuestions,
                                  "timeLimit": selectedTime
                                }
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              label: const Text(
                                'Create Quiz',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              icon: Icon(Icons.arrow_forward,size: 18,),
                              iconAlignment: IconAlignment.end,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildFilterSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }

  void _showQuizCreatedDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizDetailScreen(
          level: selectedLevel,
          category: selectedCategory,
          questions: selectedQuestions,
          timeLimit: selectedTime,
        ),
      ),
    );
  }
}
