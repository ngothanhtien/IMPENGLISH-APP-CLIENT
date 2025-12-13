import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/custom_textfield.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppSnackBar.showError(context, "Please enter full email and password!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await AuthService().login(email: email, password: password);

      if (!mounted) return;

      final title = response['title']?.toString() ?? '';
      final message = response['message']?.toString() ?? '';

      if (title == 'Success') {
        await Future.delayed(const Duration(seconds: 2));
        setState(() => _isLoading = false);
        if (mounted) context.go('/home');
      } else {
        setState(() => _isLoading = false);
        AppSnackBar.showError(context, message);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      AppSnackBar.showError(context, "Login failed: $e");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                // Header Section with Gradient
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF3D5CFF),
                        Color(0xFF5B7CFF),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    child: Column(
                      children: [
                        // Logo/Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to continue learning",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.5
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      // Email Field
                      CustomTextField(
                        nameTextField: "Email Address",
                        hintText: "Enter your email",
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        isPassword: false,
                        titleSize: 15,
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      CustomTextField(
                        nameTextField: "Password",
                        hintText: "Enter your password",
                        controller: passwordController,
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        titleSize: 15,
                      ),
                      const SizedBox(height: 8),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => {
                            AppSnackBar.showInfo(context,
                                "Forgot password will coming soon!"
                            )
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3D5CFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3D5CFF),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF3D5CFF).withOpacity(0.6),
                            elevation: 0,
                            shadowColor: const Color(0xFF3D5CFF).withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Sign Up Link
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF858597),
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: "Sign up",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF3D5CFF),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.push('/register'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Social Login Buttons
                      Row(
                        children: [
                          // Google Button
                          Expanded(
                            child: SizedBox(
                              height: 54,
                              child: OutlinedButton(
                                onPressed: () {
                                  AppSnackBar.showInfo(
                                      context,
                                      "Login with Google will coming soon!"
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/logos/logo_gg.png",
                                      height: 26,
                                      width: 26,
                                    ),
                                    const Text("Google",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Facebook Button
                          Expanded(
                            child: SizedBox(
                              height: 54,
                              child: OutlinedButton(
                                onPressed: () {
                                  AppSnackBar.showInfo(
                                      context,
                                      "Login with Facebook will coming soon!"
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xFF1877F2),
                                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    const Text("Facebook",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}