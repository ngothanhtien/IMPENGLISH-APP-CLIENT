
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAppDialog(BuildContext context, {
  required IconData icon,
  required String title,
  required String message,
  String okText = "Ok",
  String cancelText = "Cancel",
  Color primaryColor = const Color(0xFF4F46E5),
  required VoidCallback onOk,
  AnimType animType = AnimType.rightSlide,
  double boderRadius = 12.0,
  TextAlign align = TextAlign.center,
  bool dismissOntouchOnside = true,
  bool hideBtnCancel = false,
  Color okTextColor = Colors.white,
  Color titleColor = const Color(0xFF4F46E5),

})  {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader, // Ẩn icon mặc định → UI đẹp hơn
    animType: animType,
    padding: const EdgeInsets.all(20),
    dialogBackgroundColor: Colors.white,
    dialogBorderRadius: BorderRadius.circular(boderRadius),
    dismissOnTouchOutside: dismissOntouchOnside,

    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ICON đẹp màu brand
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 32,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          message,
          textAlign: align,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            // Cancel
            Expanded(
              child: OutlinedButton(
                onPressed:hideBtnCancel ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side:  BorderSide(
                    color: Color(0xFFCFCFD3),
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: Color(0xFFB6B6BC),
                    fontWeight: FontWeight.w500,
                    fontSize: 13
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Exit
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Pop dialog
                  onOk();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  okText,
                  style: TextStyle(
                    color: okTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  ).show();
}