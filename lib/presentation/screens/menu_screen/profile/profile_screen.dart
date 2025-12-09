import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/action_card.dart';
import 'package:learning_app_client/component/widgets/alertdialog_custom.dart';
import 'package:learning_app_client/component/widgets/profile_card.dart';
import 'package:learning_app_client/model/user/user.dart';
import 'package:learning_app_client/service/auth_service.dart';
import 'package:learning_app_client/service/user_service.dart';

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
  User? user;
  bool isLoadingProfile = false;

  Future<void> _getProfile() async {
    setState(() {
      isLoadingProfile = true;
    });
    try{
      final response = await UserService().getProfile();
      if(!mounted) return;

      await Future.delayed(Duration(milliseconds: 400));
      setState(() {
        user = response;
        isLoadingProfile = false;
      });
    }catch(e){
      setState(() {
        isLoadingProfile = false;
      });
      debugPrint("Error at _getProfile: $e");
    }
  }
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
    _getProfile();
  }

  Future<void> handleLogout() async {
    if (!mounted) return;

    final storage = const FlutterSecureStorage();
    setState(() => _isLoggingOut = true);

    try {
      final refreshToken = await storage.read(key: 'refreshToken');

      // 1. Nếu không có refreshToken → chỉ xoá token & điều hướng
      if (refreshToken == null || refreshToken.isEmpty) {
        await _clearTokens(storage);
        if (!mounted) return;
        context.go('/login');
        return;
      }

      // 2. Gửi request logout tới backend
      final response = await AuthService().logOut(refreshToken: refreshToken);

      if (!mounted) return;

      final title = response['title'] ?? response['status'] ?? '';
      final message = response['message'] ?? 'Logged out successfully';

      if (title == 'Success') {
        AppSnackBar.showSuccess(context, message);
      } else {
        AppSnackBar.showError(context, message);
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, "Có lỗi khi đăng xuất: $e");
      }
    } finally {
      // 3. Dù có lỗi hay không → xoá token
      await _clearTokens(storage);

      // 4. Chỉ navigate nếu widget còn mounted
      if (mounted) {
        setState(() => _isLoggingOut = false);
        context.go('/login');
      }
    }
  }

  Future<void> _clearTokens(FlutterSecureStorage storage) async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
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
      body: isLoadingProfile || user == null ?
      Center(child: CircularProgressIndicator(),):
      FadeTransition(
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
                      children: [
                        const SizedBox(height: 5),
                        // Avatar
                        _informationCard(user!),
                        const SizedBox(height: 16),

                        // Stats Cards
                        Row(
                          children: [
                            Expanded(
                              child: ProfileCard(
                                title: 'Level',
                                value: user?.level ?? 'Anonymous',
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
                                value: user?.streakDay.toString() ?? 'N/A',
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
                                titleSize: 14,
                                valueSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ProfileCard(
                                title: 'Vocabulary Learned',
                                value: '180',
                                icon: Icons.school_outlined,
                                color: const Color(0xFFF59E0B),
                                titleSize: 14,
                                valueSize: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Action Cards
                        ActionCard(
                          title: 'Edit Profile',
                          subtitle: 'Update your personal information',
                          icon: Icons.edit,
                          color: const Color(0xFF6366F1),
                          onTap: () => context.push('/profile/edit-profile'),
                        ),
                        const SizedBox(height: 12),
                        ActionCard(
                          title: 'Achievements',
                          subtitle: 'View your badges and rewards',
                          icon: Icons.emoji_events,
                          color: const Color(0xFFF59E0B),
                          onTap: () => context.push("/profile/achievement"),
                        ),
                        const SizedBox(height: 12),

                        ActionCard(
                          title: 'Settings',
                          subtitle: 'Manage app preferences',
                          icon: Icons.settings,
                          color: const Color(0xFF64748B),
                          onTap: () => context.push('/profile/setting'),
                        ),
                        const SizedBox(height: 12),

                        ActionCard(
                          title: 'Logout',
                          subtitle: 'Sign out of your account',
                          icon: Icons.logout,
                          color: const Color(0xFFEF4444),
                          onTap: () => _showLogoutDialog(),
                        ),

                        const SizedBox(height: 24),
                      ],
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

  Widget _informationCard(User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4239DA), Color(0xFF4F46E1)], // nền nhạt
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
            width: 60,
            height: 60,
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
                    color: const Color(0xFF667EEA).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(50)
              ),
              child: Text(
                user.fullName?.split("")[0] ?? 'A',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5
                  ),
                ),
                const SizedBox(height: 12),

                // Badges
                Row(
                  children: [
                    _buildChip(user.level ?? '', Colors.green, Colors.green.shade50),
                    const SizedBox(width: 8),
                    _buildChip(user.createdAt.toString().split(' ')[0], Colors.indigo, Colors.indigo.shade50),
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
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
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
