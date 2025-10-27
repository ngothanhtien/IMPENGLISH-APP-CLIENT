import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardScreen();
}

class _LeaderBoardScreen extends State<LeaderBoardScreen> {
  final List<Map<String, dynamic>> top_learnings = [
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
              spacing: 20,
              children: [
                Expanded(
                  child: ProfileCard(
                    title: '2.4K',
                    value: 'Active Learners',
                    icon: Icons.group,
                    color: const Color(0xFF11AFE8),
                    space: 30,
                    titleSize: 24,
                    valueSize: 18,
                  ),
                ),
                Expanded(
                  child: ProfileCard(
                    title: '89%',
                    value: 'Avg Progress',
                    icon: Icons.trending_up,
                    color: const Color(0xFF10B981),
                    space: 30,
                    titleSize: 24,
                    valueSize: 18,
                  ),
                ),
                Expanded(
                  child: ProfileCard(
                    title: '156',
                    value: 'Top Scores',
                    icon: Icons.star_border,
                    color: const Color(0xFFCD730C),
                    space: 30,
                    titleSize: 24,
                    valueSize: 18,
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
                    color: Colors.black.withOpacity(0.1),
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
                      size: 40,
                    ),
                    title: const Text(
                      "Top Learners This Week",
                      style: TextStyle(
                        fontSize: 20,
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
                    itemCount: top_learnings.length,
                    itemBuilder: (context, index) {
                      final item = top_learnings[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            /// 🥇 Top rank number
                            Container(
                              width: 40,
                              height: 40,
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
                            const SizedBox(width: 16),

                            /// 👤 Avatar
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(item['avatar']),
                            ),
                            const SizedBox(width: 16),

                            /// 🧩 Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['fullname'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.1
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Text(
                                      item['level'],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 15,
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
                                        color: Colors.deepOrange, size: 20),
                                    const SizedBox(width: 4),
                                    Text("${item['streak']} day streak",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700
                                      )
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 22),
                                    const SizedBox(width: 4),
                                    Text("${item['exp']} XP",
                                      style: const TextStyle(
                                        fontSize: 17,
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
