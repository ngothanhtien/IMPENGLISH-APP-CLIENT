import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_app_client/component/textfield/custom_textfield_editprofile.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/model/user/user.dart';
import 'package:learning_app_client/service/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChangePassword = false;
  bool _isLoading = false;
  bool isLoadingProfile = false;
  bool _isSavePassword = false;
  String? avatarUrl;
  bool isLoading = false;

  final picker = ImagePicker();

  late Future<User?> currentUser;
  User? _userData;

  Future<void> pickImage() async {
    // 👉 FIX 1: Kiểm tra mounted trước khi bắt đầu
    if (!mounted) return;

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Giảm chất lượng để file nhỏ hơn
        // 👉 FIX 2: Thêm maxWidth/maxHeight để giảm kích thước
        maxWidth: 1024,
        maxHeight: 1024,
      );

      //  User cancel chọn ảnh
      if (pickedFile == null) return;

      // Kiểm tra kích thước file trước khi upload
      final file = File(pickedFile.path);
      final fileSize = await file.length();
      final fileSizeInMB = fileSize / (1024 * 1024);

      debugPrint("📦 File size: ${fileSizeInMB.toStringAsFixed(2)} MB");

      if (fileSizeInMB > 1.0) {
        if (!mounted) return;
        AppSnackBar.showError(context, "File size must be less than 1MB");
        return;
      }

      setState(() => isLoading = true);

      final newAvatar = await UserService().changeAvatar(file);

      // Log kết quả
      debugPrint("📸 New avatar URL: $newAvatar");

      if (!mounted) return;

      setState(() {
        isLoading = false;
        if (newAvatar != null) {
          avatarUrl = newAvatar;
          if (_userData != null) {
            _userData = _userData?.copyWith(
              avatar: newAvatar
            );
          }
        }
      });

      if (!mounted) return;

      if (newAvatar != null) {
        AppSnackBar.showSuccess(context, "Avatar updated successfully");
      } else {
        AppSnackBar.showError(context, "Failed to update avatar. Please try again.");
      }

    } catch (e) {

      debugPrint("❌ Error picking/uploading image: $e");

      if (!mounted) return;

      setState(() => isLoading = false);

      AppSnackBar.showError(
          context,
          "An error occurred while updating avatar"
      );
    }
  }

  Future<User?> getProfile() async {
    try {
      final response = await UserService().getProfile();
      if(!mounted) return null;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      }
      return null;
    } catch (e) {
      debugPrint("Error at _getProfile: $e");
      return null;
    }
  }

  Future<void> changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isSavePassword = true;
    });
    try {
      final response = await UserService().changePassword(
        oldPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text
      );
      if(!mounted) return;
      if(response.statusCode == 200){
        await Future.delayed(Duration(milliseconds: 800));
        if(!mounted) return;
        AppSnackBar.showSuccess(context, "Change password successfully");
        setState(() {
          _currentPasswordController.text = '';
          _newPasswordController.text = '';
          _confirmPasswordController.text = '';
          _isSavePassword = false;
          _isChangePassword = false;
          _isPasswordVisible = false;
          _isConfirmPasswordVisible = false;
          _isNewPasswordVisible = false;
        });
      }else{
        await Future.delayed(Duration(milliseconds: 800));
        final data = jsonDecode(response.body);
        String mes = data['message'] ?? "Unknown Error";
        if(!mounted) return;
        AppSnackBar.showError(context, mes);
        setState(() {
          _isSavePassword = false;
        });
      }
    } catch (e) {
      setState(() {
        _isSavePassword = false;
      });
      debugPrint("Error at _getProfile: $e");
    }
  }

  Future<void> updateUserProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await UserService().updateProfile({
        "fullName": _fullNameController.text.trim().isNotEmpty
            ? _fullNameController.text
            : '',
        'phone': _phoneController.text.trim().isNotEmpty
            ? _phoneController.text
            : '',
      });

      if (!mounted) return;

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        await Future.delayed(const Duration(milliseconds: 800));
        if(!mounted) return;
        AppSnackBar.showSuccess(context, "Update profile Successfully");
        // Update local user data
        setState(() {
          _userData = User.fromJson(body['user']);
          _isLoading = false;
        });
      } else {
        final body = json.decode(response.body);
        final msg = body['message'] ?? "Unknown Error";
        await Future.delayed(const Duration(milliseconds: 800));
        if(!mounted) return;
        AppSnackBar.showError(context, msg);
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint("Error at updateUserProfile: $e");
      if (mounted) {
        setState(() => _isLoading = false);
        AppSnackBar.showError(context, "An error occurred");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    currentUser = getProfile();
  }

  void _loadUserData(User user) {
    _fullNameController.text = user.fullName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phone ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: currentUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          // Load user data only once
          if (_userData == null) {
            _userData = snapshot.data;
            _loadUserData(_userData!);
          }

          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        }

        return const Scaffold(
          body: Center(child: Text('No User Data found')),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF4F46E5),
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: Colors.white.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white),
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.2
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: const Color(0xFFE2E8F0),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          _buildProfileHeader(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  _buildSectionTitle('Personal Information'),
                  const SizedBox(height: 12),
                  _buildPersonalInfoSection(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Contact Information'),
                  const SizedBox(height: 12),
                  _buildContactInfoSection(),
                  const SizedBox(height: 12),
                  _buildPasswordSection(),
                  const SizedBox(height: 12),
                  _buildSaveButton(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    // 👉 FIX 1: Ưu tiên avatarUrl mới, fallback về _userData
    final displayAvatarUrl = avatarUrl ?? _userData?.avatar;

    // 👉 FIX 2: Default avatar nếu không có gì
    const defaultAvatar = "https://img.freepik.com/free-vector/smiling-young-"
        "man-illustration_1308-174669.jpg?semt=ais_hybrid&w=740&q=80";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Column(
        children: [
          // 👉 FIX 3: Tách logic loading ra khỏi Badge
          Stack(
            alignment: Alignment.center,
            children: [
              // Avatar chính
              Badge(
                backgroundColor: Colors.transparent,
                alignment: const Alignment(0.35, 1.0),
                label: GestureDetector(
                  onTap: isLoading ? null : pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    // 👉 FIX 4: Disable camera icon khi đang loading
                    child: Icon(
                      Icons.camera_alt,
                      color: isLoading ? Colors.grey : Colors.white,
                      size: 16,
                    ),
                  ),
                ),

                // 👉 FIX 5: Avatar luôn hiển thị, không bị thay bằng loading
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  // 👉 FIX 6: Xử lý image provider đúng cách
                  backgroundImage: (displayAvatarUrl != null && displayAvatarUrl.isNotEmpty)
                      ? NetworkImage(displayAvatarUrl)
                      : NetworkImage(defaultAvatar),
                  // 👉 FIX 7: Thêm error widget nếu load ảnh fail
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint("❌ Error loading avatar image: $exception");
                  },
                ),
              ),

              // 👉 FIX 8: Overlay loading indicator lên trên avatar
              if (isLoading)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 22),

          // 👉 FIX 9: Text thay đổi theo trạng thái
          Text(
            isLoading ? 'Uploading...' : 'Change Profile Picture',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isLoading ? Colors.grey : const Color(0xFF667EEA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFieldEditProfile(
            controller: _fullNameController,
            label: 'Full Name',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const CustomDivider(),
          CustomTextFieldEditProfile(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            enabled: false,
            suffixIcon: Icons.lock_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFieldEditProfile(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Security'),
            TextButton.icon(
              onPressed: () {
                setState(() => _isChangePassword = !_isChangePassword);
              },
              icon: Icon(
                _isChangePassword ? Icons.close : Icons.edit,
                size: 18,
                color: const Color(0xFF667EEA),
              ),
              label: Text(
                _isChangePassword ? 'Cancel' : 'Change Password',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF667EEA),
                ),
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isChangePassword
              ? Container(
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _passwordFormKey,
              child: Column(
                children: [
                  CustomTextFieldEditProfile(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixIconTap: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                    validator: (value) {
                      if (_isChangePassword && (value == null || value.isEmpty)) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  const CustomDivider(),
                  CustomTextFieldEditProfile(
                    controller: _newPasswordController,
                    label: 'New Password',
                    icon: Icons.lock_outline,
                    obscureText: !_isNewPasswordVisible,
                    suffixIcon: _isNewPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixIconTap: () {
                      setState(() => _isNewPasswordVisible = !_isNewPasswordVisible);
                    },
                    validator: (value) {
                      if (_isChangePassword && (value == null || value.isEmpty)) {
                        return 'Please enter a new password';
                      }
                      if (_isChangePassword && value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("The new password must be at least 6 characters long: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54
                        ),
                      ),
                      Text("including both uppercase, lowercase, and numbers.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  const CustomDivider(),
                  CustomTextFieldEditProfile(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    icon: Icons.lock_outline,
                    obscureText: !_isConfirmPasswordVisible,
                    suffixIcon: _isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixIconTap: () {
                      setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                    },
                    validator: (value) {
                      if (_isChangePassword && (value == null || value.isEmpty)) {
                        return 'Please confirm your new password';
                      }
                      if (_isChangePassword && value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSavePassword ? null : changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          disabledBackgroundColor: const Color(0xFF6EE7B7),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isSavePassword
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Saving...",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.lock_open_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Save Password",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12,)
                ],
              ),
            ),
          )
              : Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF10B981),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password is secure',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Last changed 30 days ago',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : updateUserProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: const Color(0xFF94A3B8),
        ),
        child: _isLoading
            ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white60,
                  strokeWidth: 3,
                ),
                SizedBox(width: 8,),
                Text(
                  '...Updating',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60
                  ),
                ),
              ],
            )
          : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_outlined, size: 22),
            SizedBox(width: 12),
            Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Divider Widget
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1.2,
      color: Colors.black26,
    );
  }
}