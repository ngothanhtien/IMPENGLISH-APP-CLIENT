import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? nameTextField;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;
  final double titleSize;
  final Color titleColor;
  final bool showTitle;
  final Function(String)? onchanged;

  const CustomTextField({
    super.key,
    this.nameTextField,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    this.titleSize = 18,
    this.titleColor = const Color(0xFF525E71),
    this.prefixIcon,
    this.errorText,
    this.onchanged,
    this.showTitle = true
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // quản lý ẩn/hiện mật khẩu

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle)
          Text(
            widget.nameTextField ?? "",
            style: TextStyle(
              fontSize: widget.titleSize,
              color: widget.titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),

        if (widget.showTitle) const SizedBox(height: 6),
        TextField(
          onChanged: widget.onchanged,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20)
                : null,
            // thêm suffixIcon nếu là password
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
              const BorderSide(color: Color(0xFF3D5CFF), width: 1.4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.5),
              width: 1.2),
            ),
            hintStyle: const TextStyle(
              color: Color(0xFF858597),
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            errorText: widget.errorText,
          ),
        ),
      ],
    );
  }
}
