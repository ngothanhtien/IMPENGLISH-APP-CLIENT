import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';

class RecommendedTopics extends StatelessWidget {
  const RecommendedTopics({super.key});

  final List<Map<String, dynamic>> topics = const [
    {
      'title': 'Business English',
      'icon': Icons.business_center,
      'color': Color(0xFF4F46E5),
      'words': 45,
    },
    {
      'title': 'Travel & Tourism',
      'icon': Icons.flight,
      'color': Color(0xFF10B981),
      'words': 32,
    },
    {
      'title': 'Technology',
      'icon': Icons.computer,
      'color': Color(0xFFF59E0B),
      'words': 28,
    },
    {
      'title': 'Daily Conversation',
      'icon': Icons.chat,
      'color': Color(0xFFEF4444),
      'words': 56,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return ProfileCard(
          icon: topic['icon'],
          color: topic['color'],
          title: topic['title'],
          value: '${topic['words']} words',
          space: 15,
          titleSize: 18,
          valueSize: 16,
        );
      },
    );
  }
}
