import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestedCategories extends StatelessWidget {
  const SuggestedCategories({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Animals',
      'icon': Icons.pets,
      'color': Color(0xFF10B981),
    },
    {
      'title': 'Business',
      'icon': Icons.business_center,
      'color': Color(0xFF4F46E5),
    },
    {
      'title': 'Travel',
      'icon': Icons.flight,
      'color': Color(0xFFF59E0B),
    },
    {
      'title': 'Food',
      'icon': Icons.restaurant,
      'color': Color(0xFFEF4444),
    },
    {
      'title': 'Technology',
      'icon': Icons.computer,
      'color': Color(0xFF8B5CF6),
    },
    {
      'title': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Color(0xFF06B6D4),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
            color: Color(0xFF1E293B),
            height: 1.1
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => context.push("/home/vocabulary-topic/${category['title']}"),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        category['icon'],
                        color: category['color'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        category['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
