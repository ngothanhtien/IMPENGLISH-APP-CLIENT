import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/CustomTextField.dart';
import 'package:learning_app_client/service/userService.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';

class RegisterScreen extends StatefulWidget{
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
      final result = await userService().signUp(
          fullName: fullnameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      final res_result = result['status'] ?? result['title'] ?? '';
      final message = result['message'] ?? '';

      if(res_result == 'failed' || res_result == 'BAD REQUEST'){
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
                        height: 200,
                        width: double.infinity,
                        color: const Color(0xFF3D5CFF),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              "Connect with IMPEnglish today!",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 50,),
                          ],
                        ),
                      ),
                      // ---------- HEADER ----------
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 40
                        ),
                        child: Column(
                          children: [
                            // ---------- FORM ----------
                            Container(
                              child: Column(
                                children: [
                                  CustomTextField(
                                    nameTextField: "Full Name",
                                    hintText: "Enter your full name",
                                    controller: fullnameController,
                                    prefixIcon: Icons.account_box,
                                    isPassword: false,
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    nameTextField: "Email",
                                    hintText: "Enter your email",
                                    controller: emailController,
                                    prefixIcon: Icons.email_outlined,
                                    isPassword: false,
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    nameTextField: "Password",
                                    hintText: "Enter password for your account",
                                    controller: passwordController,
                                    prefixIcon: Icons.lock,
                                    isPassword: true,
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    nameTextField: "Confirm Password",
                                    hintText: "Password confirm have to same with password",
                                    controller: confirmPasswordController,
                                    prefixIcon: Icons.lock,
                                    isPassword: true,
                                  ),
                                  const SizedBox(height: 35),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 72,
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
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
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
                                          fontSize: 18,
                                          color: Color(0xFF858597),
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
                                            fontSize: 19,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Log in",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF3D5CFF),
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => context.go('/login'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                color: Colors.black.withOpacity(0.2), // nền mờ
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