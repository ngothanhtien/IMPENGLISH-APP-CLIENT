import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        curve: Curves.easeInOut,
        backgroundColor: Colors.white,
        color: Colors.grey, // màu khi chưa chọn
        activeColor: const Color(0xFF3D5CFF), // màu tab đang chọn
        style: TabStyle.flip, // kiểu hiện đại, có animation
        initialActiveIndex: navigationShell.currentIndex,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.school, title: 'Learn'),
          TabItem(icon: Icons.psychology_alt, title: 'Quiz'),
          TabItem(icon: Icons.group, title: 'Community'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
