import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({
    super.key
  });
  @override
  State<StatefulWidget> createState() => _LeaderBoardScreen();
}

class _LeaderBoardScreen extends State<LeaderBoardScreen> {
  final List<Map<String, dynamic>> topLearnings = [
    {
      "id": 1,
      "fullname": "David Ngo",
      "streak": 79,
      "level": "Grammar Master",
      "exp": 2450,
      "avatar":
      "https://randomuser.me/api/portraits/men/32.jpg",
    },
    {
      "id": 2,
      "fullname": "Maria Santos",
      "streak": 55,
      "level": "Vocabulary Pro",
      "exp": 2350,
      "avatar":
      "https://randomuser.me/api/portraits/women/47.jpg",
    },
    {
      "id": 3,
      "fullname": "Lisa Wang",
      "streak": 35,
      "level": "Grammar Expert",
      "exp": 1950,
      "avatar":
      "https://randomuser.me/api/portraits/women/12.jpg",
    },
    {
      "id": 4,
      "fullname": "David Park",
      "streak": 40,
      "level": "Listening Hero",
      "exp": 1960,
      "avatar":
      "https://randomuser.me/api/portraits/men/21.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🧠 Summary cards
            Row(
              spacing: 6,
              children: [
                Expanded(
                  child: ProfileCard(
                    title: '2.4K',
                    value: 'Learners',
                    icon: Icons.group,
                    color: const Color(0xFF11AFE8),
                    titleSize: 18,
                    valueSize: 14,
                  ),
                ),
                Expanded(
                  child: ProfileCard(
                    title: '89%',
                    value: 'Avg Progress',
                    icon: Icons.trending_up,
                    color: const Color(0xFF10B981),
                    titleSize: 18,
                    valueSize: 14,
                  ),
                ),
                Expanded(
                  child: ProfileCard(
                    title: '156',
                    value: 'Top Scores',
                    icon: Icons.star_border,
                    color: const Color(0xFFCD730C),
                    titleSize: 18,
                    valueSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🏆 Top Learners
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.emoji_events,
                      color: Color(0xFFF59E0B),
                      size: 32,
                    ),
                    title: const Text(
                      "Top Learners This Week",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Danh sách người học top
                  ListView.builder(
                    shrinkWrap: true, // ✅ cho phép ListView trong Column
                    physics: const NeverScrollableScrollPhysics(), // ✅ tránh lỗi cuộn lồng nhau
                    itemCount: topLearnings.length,
                    itemBuilder: (context, index) {
                      final item = topLearnings[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black.withValues(alpha: 0.1),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            /// 🥇 Top rank number
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${item['id']}",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),

                            /// 👤 Avatar
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(item['avatar']),
                            ),
                            const SizedBox(width: 6),
                            /// 🧩 Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['fullname'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.1
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Text(
                                      item['level'],
                                      style: TextStyle(
                                        color: const Color(0xFF525E71),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /// 🔥 Stats
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.local_fire_department,
                                        color: Colors.deepOrange, size: 18),
                                    const SizedBox(width: 4),
                                    Text("${item['streak']} day streak",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF525E71),
                                        fontWeight: FontWeight.w600,
                                        height: 1.5
                                      )
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 18),
                                    const SizedBox(width: 4),
                                    Text("${item['exp']} XP",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700
                                      )
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
