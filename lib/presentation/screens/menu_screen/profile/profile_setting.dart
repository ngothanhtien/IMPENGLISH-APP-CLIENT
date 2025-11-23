import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text("Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w700
          ),
        ),
        leading: IconButton(
            onPressed: ()=> context.pop(),
            style: IconButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
            ),
            icon: Icon(Icons.arrow_back,size: 24,color: Colors.white,)
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // ⚙️ Danh sách tùy chọn
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard([
                    _buildSettingItem(
                      icon: LucideIcons.shieldCheck,
                      title: "Privacy & Security",
                      subtitle: "Manage account security",
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 25),

                  const Text(
                    "App Settings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard([
                    _buildSettingItem(
                      icon: LucideIcons.moon,
                      title: "Dark Mode",
                      subtitle: "Switch app appearance",
                      trailing: Switch(
                        value: false,
                        onChanged: (v) {},
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.bell,
                      title: "Notifications",
                      subtitle: "Push and email alerts",
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.globe,
                      title: "Language",
                      subtitle: "English (US)",
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 25),

                  const Text(
                    "Support",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard([
                    _buildSettingItem(
                      icon: LucideIcons.handHelping100,
                      title: "Help Center",
                      subtitle: "FAQs & Support",
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.mail,
                      title: "Contact Us",
                      subtitle: "Get in touch with our team",
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🧱 Hàm dựng nhóm thẻ
  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // 🪶 Một item trong danh sách
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: const Color(0xFF6366F1)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else
              const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
