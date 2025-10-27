import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  final List<String> recentSearches = const [
    'serendipity',
    'ephemeral',
    'resilience',
    'ubiquitous',
    'mellifluous',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Clear All',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...recentSearches.map((search) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              search,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF1E293B),
              ),
            ),
            leading: const Icon(
              Icons.history,
              color: Color(0xFF64748B),
              size: 22,
            ),
            trailing: const Icon(
              Icons.north_west,
              color: Color(0xFF64748B),
              size: 18,
            ),
          ),
        )).toList(),
      ],
    );
  }
}
