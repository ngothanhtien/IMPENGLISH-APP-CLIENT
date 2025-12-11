import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/action_card.dart';
import 'package:learning_app_client/component/widgets/alertdialog_custom.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';
import 'package:learning_app_client/service/auth_service.dart';

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
  final storage = FlutterSecureStorage();
  bool _isloadingUser = false;
  Map<String,dynamic>? user;
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
    loadDataUser();
  }

  Future<void> handleLogout() async {
    if (!mounted) return;

    setState(() => _isLoggingOut = true);

    try {
      final response = await AuthService().logOut();

      if (!mounted) return;

      // Nếu response null → có nghĩa refreshToken không tồn tại → đăng xuất luôn
      if (response == null) {
        AppSnackBar.showSuccess(context, "Logged out successfully");
      } else {
        final title = response['title'] ?? response['status'] ?? '';
        final message = response['message'] ?? 'Logged out successfully';

        if (title == 'Success') {
          AppSnackBar.showSuccess(context, message);
        } else {
          AppSnackBar.showError(context, message);
        }
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, "Có lỗi khi đăng xuất: $e");
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
        context.go('/login');  // Điều hướng cuối cùng
      }
    }
  }

  Future<void> loadDataUser() async{
    setState(() {
      _isloadingUser = true;
    });

    try{
      String? jsonString = await storage.read(key: 'user');

      if(jsonString !=null){

        Map<String,dynamic> data = jsonDecode(jsonString);
        setState(() {
          user = data;
          _isloadingUser = false;

        });

      }else{
        debugPrint("No user data in storage");
        setState(() {
          _isloadingUser = false;
        });
      }
    }catch(e){
      debugPrint("Error loading user data: $e");
      setState(() {
        _isloadingUser = false;
      });
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
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5
          ),
        ),
      ),
      body: _isloadingUser
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : user == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_off_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No user data available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: loadDataUser,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ): FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SafeArea(
                  child: Column(
                    children: [
                      // Header Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 12),

                          // ===== LEARNING STATISTICS SECTION =====
                          _buildSectionHeader(
                            title: 'Learning Statistics',
                            icon: Icons.analytics_outlined,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0D9488), Color(0xFF14B8A6)],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Stats Cards Row 1
                          Row(
                            children: [
                              Expanded(
                                child: ProfileCard(
                                  title: 'Level',
                                  value: user?['level']?.toString() ?? '0',
                                  icon: Icons.trending_up,
                                  color: const Color(0xFF10B981),
                                  titleSize: 14,
                                  valueSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Day Streak',
                                  value: user?['streakDay']?.toString() ?? '0',
                                  icon: Icons.local_fire_department,
                                  color: const Color(0xFFEA8E31),
                                  titleSize: 14,
                                  valueSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Quizzes',
                                  value: '7',
                                  icon: Icons.quiz,
                                  color: const Color(0xFF6366F1),
                                  titleSize: 14,
                                  valueSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Stats Cards Row 2
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ProfileCard(
                                  title: 'Average Score',
                                  value: '85%',
                                  icon: Icons.star,
                                  color: const Color(0xFFF59E0B),
                                  titleSize: 14,
                                  valueSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ProfileCard(
                                  title: 'Vocabulary',
                                  value: '180',
                                  icon: Icons.school_outlined,
                                  color: const Color(0xFF8B5CF6),
                                  titleSize: 14,
                                  valueSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ===== ACCOUNT MANAGEMENT SECTION =====
                          _buildSectionHeader(
                            title: 'Account Management',
                            icon: Icons.manage_accounts_outlined,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Action Cards
                          ActionCard(
                            title: 'Edit Profile',
                            subtitle: 'Update your personal information',
                            icon: Icons.edit_outlined,
                            color: const Color(0xFF6366F1),
                            onTap: () => context.push(
                                '/profile/edit-profile',
                                extra: user
                            ),
                          ),
                          const SizedBox(height: 12),

                          ActionCard(
                            title: 'Achievements',
                            subtitle: 'View your badges and rewards',
                            icon: Icons.emoji_events_outlined,
                            color: const Color(0xFFF59E0B),
                            onTap: () => context.push("/profile/achievement"),
                          ),
                          const SizedBox(height: 12),

                          ActionCard(
                            title: 'Settings',
                            subtitle: 'Manage app preferences',
                            icon: Icons.settings_outlined,
                            color: const Color(0xFF64748B),
                            onTap: () => context.push('/profile/setting'),
                          ),
                          const SizedBox(height: 12),

                          ActionCard(
                            title: 'Logout',
                            subtitle: 'Sign out of your account',
                            icon: Icons.logout_outlined,
                            color: const Color(0xFFEF4444),
                            onTap: () => _showLogoutDialog(),
                          ),

                          const SizedBox(height: 24),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showAppDialog(
      context,
      icon: Icons.logout,
      title: 'Log out',
      message: 'Do you really want to logout the App?',
      onOk: handleLogout,
      titleColor: Colors.red,
      primaryColor: Colors.red,
      align: TextAlign.center,
      animType: AnimType.scale
    );
  }
}
