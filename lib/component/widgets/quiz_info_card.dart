import 'package:flutter/material.dart';

class QuizInfoCard extends StatelessWidget {
  final String category;
  final String level;
  final String questions;
  final String timeLimit;

  const QuizInfoCard({
    super.key,
    required this.category,
    required this.level,
    required this.questions,
    required this.timeLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF4F46E5),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Quiz Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            _getQuizDescription(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Quick stats
          Row(
            children: [
              _buildQuickStat(Icons.timer, timeLimit),
              const SizedBox(width: 20),
              _buildQuickStat(Icons.quiz, '$questions questions'),
              const SizedBox(width: 20),
              _buildQuickStat(Icons.trending_up, level),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.8),
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getQuizDescription() {
    final Map<String, String> categoryDescriptions = {
      'Technology': 'Dive into the world of tech innovations, programming concepts, and digital trends. Perfect for tech enthusiasts!',
      'Business': 'Test your knowledge of business strategies, entrepreneurship, and market dynamics in this comprehensive quiz.',
      'Education': 'Explore educational theories, teaching methods, and learning principles in this informative challenge.',
      'Sports': 'From legendary athletes to historic moments, challenge yourself with sports trivia and facts.',
      'Entertainment': 'Movies, music, celebrities, and pop culture - test your entertainment knowledge!',
      'Science': 'Discover the wonders of scientific discoveries, theories, and natural phenomena.',
      'History': 'Journey through time with questions about historical events, figures, and civilizations.',
      'Art & Culture': 'Explore the rich world of art, literature, and cultural heritage from around the globe.',
    };

    return categoryDescriptions[category] ??
        'Challenge yourself with this carefully curated quiz designed to test your knowledge and expand your understanding.';
  }
}