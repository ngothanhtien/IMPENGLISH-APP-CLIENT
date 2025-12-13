import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

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
    this.showTitle = true,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.focusNode,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  bool _isFocused = false;
  late FocusNode _internalFocusNode;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Label
        if (widget.showTitle && widget.nameTextField != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.nameTextField!,
              style: TextStyle(
                fontSize: widget.titleSize,
                color: widget.titleColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),

        // TextField Container with Animation
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused
                ? [
              BoxShadow(
                color: const Color(0xFF3D5CFF).withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _internalFocusNode,
            obscureText: widget.isPassword ? _obscureText : false,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onchanged,
            style: TextStyle(
              fontSize: 16,
              color: widget.enabled ? Colors.black87 : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),

              // Prefix Icon with Animation
              prefixIcon: widget.prefixIcon != null
                  ? AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  widget.prefixIcon,
                  size: 22,
                  color: _isFocused
                      ? const Color(0xFF3D5CFF)
                      : Colors.grey.shade500,
                ),
              )
                  : null,

              // Suffix Icon for Password Toggle
              suffixIcon: widget.isPassword
                  ? ScaleTransition(
                scale: _scaleAnimation,
                child: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: _isFocused
                        ? const Color(0xFF3D5CFF)
                        : Colors.grey.shade500,
                    size: 22,
                  ),
                  onPressed: () {
                    _animationController.forward().then((_) {
                      _animationController.reverse();
                    });
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              )
                  : null,

              // Border Styling
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF3D5CFF),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFFF5252),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFFF5252),
                  width: 2,
                ),
              ),

              // Fill Color
              filled: true,
              fillColor: widget.enabled
                  ? (_isFocused ? Colors.white : Colors.grey.shade50)
                  : Colors.grey.shade100,

              // Content Padding
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              // Error Text
              errorText: widget.errorText,
              errorStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),

              // Counter
              counterStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}