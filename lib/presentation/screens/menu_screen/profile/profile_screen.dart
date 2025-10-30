import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/component/widgets/action_card.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';
import 'package:learning_app_client/service/authService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }
  Future<void> handlelogout() async {
    final storage = const FlutterSecureStorage();

    setState(() => _isLoggingOut = true);

    try{
      final refreshToken = await storage.read(key: 'refreshToken');

      if(refreshToken == null || refreshToken.isEmpty){
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        AppSnackBar.showSuccess(context, "Logged out");
        if (mounted) context.go('/login');
        return;
      }
      final response = await authService().logOut(refreshToken: refreshToken);

      final title = response['title'] ?? response['status'] ?? '';
      final message = response['message'] ?? 'Logged out successfully';
      if(title == 'Success'){
        Future.delayed(const Duration(seconds: 1), (){
          if(mounted) context.go('/login');
          AppSnackBar.showSuccess(context, message);
        });
      }else{
        AppSnackBar.showError(context, message);
      }
    }catch (e) {
      AppSnackBar.showError(context, "Đã xảy ra lỗi khi đăng xuất: $e");
    } finally {
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');

      setState(() => _isLoggingOut = false);

      if (mounted) context.go('/login');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text("Profile",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5
          ),
        ),
        leading: IconButton(
            onPressed: () => context.go("/home"),
            icon: Icon(Icons.arrow_back,size: 28,color: Colors.white,)
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20
              ),
              child: SafeArea(
                  child: Column(
                    children: [
                      // Header Section
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // Avatar
                          _informationCard(),
                          const SizedBox(height: 16),

                          // Stats Cards
                          Row(
                            children: [
                              Expanded(
                                child: ProfileCard(
                                  title: 'Level',
                                  value: 'Advanced',
                                  icon: Icons.trending_up,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Day Streak',
                                  value: '36',
                                  icon: Icons.local_fire_department,
                                  color: const Color(0xFFD7E37431),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Quizzes',
                                  value: '47',
                                  icon: Icons.quiz,
                                  color: const Color(0xFF6366F1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ProfileCard(
                                  title: 'Average Score',
                                  value: '85%',
                                  icon: Icons.star,
                                  color: const Color(0xFFF59E0B),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Vocabulary Learned',
                                  value: '180',
                                  icon: Icons.school_outlined,
                                  color: const Color(0xFFF59E0B),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Action Cards
                          ActionCard(
                            title: 'Edit Profile',
                            subtitle: 'Update your personal information',
                            icon: Icons.edit,
                            color: const Color(0xFF6366F1),
                            onTap: () => context.push('/profile/edit-profile'),
                          ),
                          const SizedBox(height: 16),
                          ActionCard(
                            title: 'Achievements',
                            subtitle: 'View your badges and rewards',
                            icon: Icons.emoji_events,
                            color: const Color(0xFFF59E0B),
                            onTap: () => _showComingSoon('Achievements'),
                          ),
                          const SizedBox(height: 16),

                          ActionCard(
                            title: 'Settings',
                            subtitle: 'Manage app preferences',
                            icon: Icons.settings,
                            color: const Color(0xFF64748B),
                            onTap: () => context.push('/profile/setting'),
                          ),
                          const SizedBox(height: 16),

                          ActionCard(
                            title: 'Logout',
                            subtitle: 'Sign out of your account',
                            icon: Icons.logout,
                            color: const Color(0xFFEF4444),
                            onTap: () => _showLogoutDialog(),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _informationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4239DA), Color(0xFF4F46E1)], // nền nhạt
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 6),
            blurRadius: 12,
          )
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child:  Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(50)
              ),
              child: Text(
                'TT',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thành Tiến',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'ngothanhtien1406@gmail.com',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5
                  ),
                ),
                const SizedBox(height: 12),

                // Badges
                Row(
                  children: [
                    _buildChip("Beginner", Colors.green, Colors.green.shade50),
                    const SizedBox(width: 8),
                    _buildChip("Joined Sep 2025", Colors.indigo, Colors.indigo.shade50),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Color(0xFFEF4444), size: 28),
              SizedBox(width: 12),
              Text('Logout'),
            ],
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: handlelogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
