import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/countdown_timer/countdown_timer.dart';
import 'package:learning_app_client/component/otp-verify/custom_otp_field.dart';
import 'package:learning_app_client/component/widgets/alertdialog_custom.dart';
import 'package:learning_app_client/service/user_service.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
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
      final response = await UserService().veryfyOtp(
        email: widget.email.toString().trim(),
        otp: int.parse(otpCode),
      );

      if(!mounted) return;

      final result = response["title"] ?? '';
      final message = response['message'] ?? '';

      if (result == 'NOT FOUND') {
        AppSnackBar.showError(context,message);
        return;
      } else {
        Future.delayed(const Duration(milliseconds: 3000), () {
          if (mounted) _showDialogDone();
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
  void _showDialogDone(){
    showAppDialog(
      context,
      icon: Icons.check_circle,
      title: "Verify Successfully",
      message: 'Congratulations, you have completed your registration!',
      onOk: (){context.go('/login');},
      align: TextAlign.center,
      animType: AnimType.scale,
      dismissOntouchOnside: false,
      okText: 'Done',
      hideBtnCancel: true
    );
  }

  Future<void> _resendOTP() async {
    try{
      final response = await UserService().resendOtp(email: widget.email.toString().trim());

      if(!mounted) return;

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
        title: Text("Verify OTP",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18
        ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4F46E5),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.cancel,size: 24,color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 12,),
                CountdownTimerWidget(
                  minutes: 1,
                  onComplete: () => AppSnackBar.showError(context,"Time is up"),
                  size: 60,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Enter the 6-digit code sent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5
                  ),
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
                const SizedBox(height: 24),
                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Code will expire in 1 minute",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _resendOTP,
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4F46E5),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2,
                      decorationColor: Color(0xFF4F46E5),
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
