import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpField extends StatelessWidget {
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  const CustomOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      obscureText: false,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(
        fontSize: 16,
        color: const Color(0xFF4F46E5)
      ),
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 300),
      onCompleted: onCompleted,
      onChanged: onChanged,
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 55,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveColor: Colors.grey.shade400,
        selectedColor: const Color(0xFF4F46E5),
        activeColor: const Color(0xFF4F46E5),
      ),
    );
  }
}
