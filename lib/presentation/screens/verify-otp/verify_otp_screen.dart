import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/otp-verify/custom_otp_field.dart';
import 'package:learning_app_client/service/userService.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/component/dialog_done_verify/dialogDone.dart';
class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key,required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String otpCode = "";
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    if (otpCode.length != 6) {
      AppSnackBar.showError(context,"Vui lòng nhập mã OTP phải đủ 6 số!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await userService().veryfyOtp(
        email: widget.email.toString().trim(),
        otp: int.parse(otpCode),
      );

      final result = response["title"] ?? '';
      final message = response['message'] ?? '';

      if (result == 'NOT FOUND') {
        AppSnackBar.showError(context,message);
        return;
      } else {
        Future.delayed(const Duration(milliseconds: 3000), () {
          if (mounted) showDialogDone(context);
        });
      }
    } catch (e) {
      AppSnackBar.showError(context,"Có lỗi xảy ra khi xác thực OTP");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendOTP() async {
    try{
      final response = await userService().resendOtp(email: widget.email.toString().trim());
      final title = response['title'];
      final message = response['message'] ?? '';
      if(title == 'BAD REQUEST' || title == 'FAILED'){
        AppSnackBar.showError(context,message);
      }else{
        AppSnackBar.showSuccess(context, message);
      }
    }catch(e){
      AppSnackBar.showError(context,"Có lỗi xảy ra khi yêu cầu gửi lại mã OTP");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(vertical: 20),
        title: Text("Verify OTP",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 30
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: GestureDetector(
          onTap: () => context.go('/register'),
          child: Icon(Icons.cancel,size: 35,color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Stack(
          children: [
            Column(
              children: [
                const Text(
                  "Enter the 6-digit code sent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 21, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                /// OTP Input
                CustomOtpField(
                  length: 6,
                  onChanged: (val) {
                    setState(() {
                      otpCode = val;
                    });
                  },
                  onCompleted: (val) {
                    setState(() {
                      otpCode = val;
                    });
                  },
                ),
                const SizedBox(height: 40),
                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child:_isLoading ?
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    :
                    const Text(
                      "Verify and Create Account",
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Code will expire in 1 minute",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _resendOTP,
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2,
                      decorationColor: Colors.blueAccent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
