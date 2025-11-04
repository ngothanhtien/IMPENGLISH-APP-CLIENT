import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AchievementScreen extends StatelessWidget {
  final List<Map<String, dynamic>> achievements = [
    {
      "title": "Grammar Master",
      "description": "Completed all grammar lessons.",
      "icon": Icons.menu_book,
      "progress": 0.8,
      "color": const Color(0xFF4F46E5),
    },
    {
      "title": "Vocabulary Builder",
      "description": "Learned 1000 new words.",
      "icon": Icons.auto_awesome,
      "progress": 0.7,
      "color": const Color(0xFF10B981),
    },
    {
      "title": "Pronunciation Pro",
      "description": "Practiced pronunciation for 50 days.",
      "icon": Icons.record_voice_over,
      "progress": 0.45,
      "color": const Color(0xFFF59E0B),
    },
    {
      "title": "Daily Learner",
      "description": "Maintained a 30-day learning streak.",
      "icon": Icons.local_fire_department,
      "progress": 0.9,
      "color": const Color(0xFFEF4444),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text(
          "Achievements",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          onPressed: () => context.pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.emoji_events, color: Colors.amber, size: 40),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- Tổng quan ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat("Leaner of the week", "3", Icons.emoji_events_sharp),
                  _buildStat("Total Badges", "12", Icons.workspace_premium),
                  _buildStat("Current Level", "intermediate", Icons.trending_up),
                  _buildStat("Points", "2450", Icons.stars),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Danh sách Achievements ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final item = achievements[index];
                return _buildAchievementCard(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 40),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8,),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item['color'].withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item['icon'], color: item['color'], size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: item['progress'],
                    backgroundColor: Colors.grey.shade200,
                    color: item['color'],
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (item['progress'] == 1.0)
            const Icon(Icons.emoji_events, color: Color(0xFFFACC15), size: 28),
        ],
      ),
    );
  }
}
