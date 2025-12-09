import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/custom_textfield.dart';
import 'package:learning_app_client/service/user_service.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}
class _RegisterScreen extends State<RegisterScreen> {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isChecked = false;
  bool _isLoading = false;

  Future<void> _handlerRegister() async {
    if(!isChecked){
      AppSnackBar.showError(context, "Bạn phải đồng ý điều khoản & điều kiện.");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      AppSnackBar.showError(context, "Mật khẩu xác nhận không trùng khớp.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try{
      final result = await UserService().signUp(
          fullName: fullnameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      if(!mounted) return;

      final resResult = result['status'] ?? result['title'] ?? '';
      final message = result['message'] ?? '';

      if(resResult == 'failed' || resResult == 'BAD REQUEST'){
        AppSnackBar.showError(context,message);
      }else{
        AppSnackBar.showSuccess(context,message.isNotEmpty ? message : "Đăng ký tài khoản thành công!");
        Future.delayed(Duration(seconds: 2),() {
          if (mounted) {
            context.go(
              "/verify-otp",
              extra: {'email': emailController.text},
            );
          }
        },
        );
      }
    }catch(e){
      AppSnackBar.showError(context,"Đã có lỗi xảy ra khi đăng ký: $e");
    }finally{
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D5CFF),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        color: const Color(0xFF3D5CFF),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Connect with IMPEnglish today!",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ---------- HEADER ----------
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            Column(
                              children: [
                                CustomTextField(
                                  nameTextField: "Full Name",
                                  hintText: "Enter your full name",
                                  controller: fullnameController,
                                  prefixIcon: Icons.account_box,
                                  isPassword: false,
                                  titleSize: 15,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  nameTextField: "Email",
                                  hintText: "Enter your email",
                                  controller: emailController,
                                  prefixIcon: Icons.email_outlined,
                                  isPassword: false,
                                  titleSize: 15,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  nameTextField: "Password",
                                  hintText: "Enter password for your account",
                                  controller: passwordController,
                                  prefixIcon: Icons.lock,
                                  isPassword: true,
                                  titleSize: 15,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  nameTextField: "Confirm Password",
                                  hintText: "Password confirm",
                                  controller: confirmPasswordController,
                                  prefixIcon: Icons.lock,
                                  isPassword: true,
                                  titleSize: 15,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _handlerRegister,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3D5CFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 6,
                                    ),
                                    child: const Text(
                                      "Create Account",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: CheckboxListTile(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                    title: const Text(
                                      "By creating an account you have to agree\nwith our terms & conditions.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF525E71),
                                      ),
                                    ),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: const Color(0xFF3D5CFF),
                                    checkColor: Colors.white,
                                    side: const BorderSide(color: Colors.grey, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: "Already have an account? ",
                                        style: TextStyle(
                                          color: Color(0xFF858597),
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Log in",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF3D5CFF),
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => context.pop(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
              if (_isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.2), // nền mờ
                child: Center(
                  child: Opacity(
                    opacity: 0.7, // làm SpinKit mờ đi
                    child: const SpinKitFadingCircle(
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}