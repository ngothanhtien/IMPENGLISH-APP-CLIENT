import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/CustomTextField.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/service/authService.dart';
class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin () async {
    final email = emailController.text.toString();
    final password = passwordController.text.toString();
    if(email.isEmpty || password.isEmpty){
      AppSnackBar.showError(context, "Vui lòng nhập đầy đủ thông tin để tiến hành đăng nhập!");
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try{
      final response = await authService().login(
        email: email,
        password: password
      );
      final title = response['title'] ?? '';
      final message = response['message'] ?? '';
      if(title.toString() == 'Success'){
        AppSnackBar.showSuccess(context, message);
        Future.delayed(const Duration(milliseconds: 3000),() => {
          if(mounted) context.go('/home'),
          AppSnackBar.showSuccess(context, message)
        });
      }else{
        AppSnackBar.showError(context, message);
      }
    }catch(e){
      AppSnackBar.showError(context, "Failed at login screen : $e");
    }finally{
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 120,
                  color: const Color(0xFF3D5CFF),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      const Text("Welcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28
                        ),
                      ),
                      Text("Enter your details below",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(height: 12,),
                      CustomTextField(
                        nameTextField: "Email",
                        hintText: "Enter your email",
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        isPassword: false,
                        titleSize: 15,
                      ),
                      SizedBox(height: 16,),
                      CustomTextField(
                        nameTextField: "Password",
                        hintText: "Enter your password",
                        controller: passwordController,
                        prefixIcon: Icons.password,
                        isPassword: true,
                        titleSize: 15,
                      ),
                      SizedBox(height: 5,),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () => context.go('/fg-password'),
                            child: Text("Forget password?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: const Color(0xFF525E71)
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D5CFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )
                            ),
                            child:_isLoading ?
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                color: Colors.white
                              ),
                            )
                            :
                            Text("Log In",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 24,),
                      RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Don’t have an account?",
                                    style: TextStyle(
                                        color: Color(0xFF858597),
                                        fontSize: 14
                                    )
                                ),
                                TextSpan(
                                    text: " Sign up",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3D5CFF),
                                      fontWeight: FontWeight.w800
                                    ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context.push('/register')
                                )
                              ]
                          )
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Color(0xFF858597),
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Or login with",
                            style: TextStyle(
                              color: Color(0xFF858597),
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Color(0xFF858597),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Nút Google
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () => context.go('/register'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.black12, width: 1.2),
                                ),
                                elevation: 3,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/logos/logo_gg.png",
                                    height: 28,
                                    width: 28,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Login with Google",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Nút Facebook
                          SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.facebook,size: 40,),
                              onPressed: () => context.go('/login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1877F2), // xanh Facebook
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                              ),
                              label: const Text(
                                "Login with Facebook",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}