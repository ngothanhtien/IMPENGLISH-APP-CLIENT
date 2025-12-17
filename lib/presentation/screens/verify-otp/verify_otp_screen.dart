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
  int timeUp = 2;
  bool enableFillCode = true;

  Future<void> _verifyOtp() async {

    setState(() => _isLoading = true);

    try {
      final response = await UserService().verifyOtp(
        email: widget.email.toString().trim(),
        otp: int.parse(otpCode),
      );

      if(!mounted) return;

      final result = response["title"] ?? '';
      final message = response['message'] ?? '';

      if (result == 'NOT FOUND') {
        await Future.delayed(Duration(milliseconds: 1200));
        setState(() {
          _isLoading = false;
        });
        if(!mounted) return;
        AppSnackBar.showError(context,message);
        return;
      } else {
        Future.delayed(const Duration(milliseconds: 1200), () {
          setState(() {
            _isLoading = false;
          });
          if (mounted) _showDialogDone();
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      AppSnackBar.showError(context,"An error occurred during the OTP verification process!");
    }
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
        setState(() {
          timeUp = 2;
          enableFillCode = true;
        });
      }
    }catch(e){
      AppSnackBar.showError(context,"An error occurred during the resend otp process.");
    }
  }

  void _showDialogDone(){
    setState(() {
      timeUp = 0;
    });
    showAppDialog(
      context,
      icon: Icons.check_circle,
      title: "Verify Successfully",
      message: 'Congratulations, you have completed your registration!',
      onOk: (){context.go('/login');},
      align: TextAlign.center,
      animType: AnimType.scale,
      dismissOntouchOnside: false,
      okText: 'Finish',
      hideBtnCancel: true,
      primaryColor: Colors.green,
      titleColor: Colors.green
    );
  }

  void _showDialogCancelVerify(){
    showAppDialog(
      context,
      icon: Icons.cancel,
      title: "Cancel",
      message: 'Do you really want to cancel verify otp for your account?',
      onOk: (){context.pop();},
      align: TextAlign.center,
      animType: AnimType.scale,
      okText: 'Confirm',
      primaryColor: Colors.deepOrangeAccent,
      titleColor: Colors.deepOrangeAccent
    );
  }

  void _showDialogTimeOut() {
    showAppDialog(
        context,
        icon: Icons.timer_outlined,
        title: "Time is up",
        message: "The verification period has expired.",
        okText: "Close",
        onOk: (){
          setState(() {
            enableFillCode = false;
          });
        },
        animType: AnimType.scale,
        primaryColor: Colors.redAccent,
        dismissOntouchOnside: false,
        align: TextAlign.center,
        hideBtnCancel: true,
        titleColor: Colors.redAccent
    );
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
            fontSize: 20
        ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4F46E5),
        leading: GestureDetector(
          onTap: _showDialogCancelVerify,
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
                  minutes: timeUp,
                  onComplete: _showDialogTimeOut,
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
                  enable: enableFillCode,
                ),
                const SizedBox(height: 24),
                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: otpCode.length != 6 ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child:_isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                    :
                    Text(
                      otpCode.length != 6 ? "Please Fill Code" : "Verify Code",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Code will expire in 2 minute",
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
                      fontSize: 14,
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
