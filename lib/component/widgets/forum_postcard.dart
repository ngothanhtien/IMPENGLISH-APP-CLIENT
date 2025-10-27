import 'package:flutter/material.dart';

class ForumPostCard extends StatelessWidget {
  final VoidCallback? onTap;
  const ForumPostCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        key: const ValueKey('Forum'),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Header: avatar + user info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTcUnv77tNZ4m9l8OvOwnDLheOSWMsrayF4rhvApkyoOF2SI9m3kAoDrx1rDCz9DAH1Lg&usqp=CAU",
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "David Ngo",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green.shade300,
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            "Advanced",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department_rounded,
                            size: 20, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          "32-day streak",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.timer_outlined,
                            size: 20, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text(
                          "2h ago",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      
            const SizedBox(height: 20),
      
            // 📝 Title + Content
            const Text(
              "Best strategies for learning business English?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "I'm preparing for a job interview and need to improve my business vocabulary. What are your favorite resources?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                height: 1.5,
                letterSpacing: 0.5,
              ),
            ),
      
            const SizedBox(height: 20),
      
            // 💬 Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ❤️ Like
                Row(
                  children: [
                    Icon(Icons.favorite_border,
                        size: 24, color: Colors.grey.shade700),
                    const SizedBox(width: 6),
                    Text("32",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade800)),
                  ],
                ),
      
                // 💭 Comment
                Row(
                  children: [
                    Icon(Icons.mode_comment_outlined,
                        size: 24, color: Colors.grey.shade700),
                    const SizedBox(width: 6),
                    Text("6",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade800)),
                  ],
                ),
      
                // 🔄 Share
                Icon(Icons.share_outlined,
                    size: 24, color: Colors.grey.shade700),
      
                // 🏷️ Tag
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Business",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF565563),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
