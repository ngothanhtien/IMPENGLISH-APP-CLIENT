import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';

class RecommendedTopics extends StatelessWidget {
  const RecommendedTopics({super.key});

  final List<Map<String, dynamic>> topics = const [
    {
      'title': 'Business',
      'icon': Icons.business_center,
      'color': Color(0xFF4F46E5),
      'words': 30,
    },
    {
      'title': 'Sports',
      'icon': Icons.sports_basketball,
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
      'title': 'Education',
      'icon': Icons.school_outlined,
      'color': Color(0xFFEF4444),
      'words': 22,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return GestureDetector(
          onTap: ()=> context.push("/home/vocabulary-topic/${topic['title']}"),
          child: ProfileCard(
            icon: topic['icon'],
            color: topic['color'],
            title: topic['title'],
            value: '+${topic['words']} words',
            spacing: 10,
            titleSize: 16,
            valueSize: 13,
          ),
        );
      },
    );
  }
}
