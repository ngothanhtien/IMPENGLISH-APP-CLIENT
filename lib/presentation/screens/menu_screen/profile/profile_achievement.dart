import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/progress_indicator_widget.dart';

class AchievementScreen extends StatelessWidget {
  AchievementScreen({super.key});
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
      "description": "Learned 300 new words.",
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
            fontSize: 20,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          onPressed: () => context.pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.menu, color: Colors.white, size: 26),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // --- Tổng quan ---
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(
                top: 20
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: _buildStat(
                      "Best Learner",
                      "3",
                      Icons.emoji_events_sharp,
                      Colors.amber
                    )
                  ),
                  Expanded(
                    child: _buildStat(
                      "Total Badges",
                      "12",
                      Icons.workspace_premium,
                      Colors.cyanAccent
                    )
                  ),
                  Expanded(
                    child: _buildStat(
                      "Points",
                      "2450",
                      Icons.stars,
                      Colors.greenAccent
                    )
                  ),
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

  Widget _buildStat(String title, String value, IconData icon, Color? color) {
    return Column(
      children: [
        Icon(icon, color: color ?? Colors.white, size: 32),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8,),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
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
            color: Colors.black.withValues(alpha: 0.15),
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
            child: Icon(item['icon'], color: item['color'], size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 8),
                ProgressIndicatorWidget(
                  progress: item['progress'],
                  height: 5,
                  color: item['color'],
                )
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
