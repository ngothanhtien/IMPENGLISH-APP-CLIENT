import 'package:flutter/material.dart';

class CustomTextFieldEditProfile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool enabled;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;

  const CustomTextFieldEditProfile({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.enabled = true,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: enabled
                  ? const Color(0xFF667EEA).withValues(alpha: 0.1)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: enabled ? const Color(0xFF667EEA) : const Color(0xFF94A3B8),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: enabled ? const Color(0xFF556171) : const Color(0xFF94A3B8),
                      letterSpacing: 0.5
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller,
                  enabled: enabled,
                  obscureText: obscureText,
                  validator: validator,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: enabled ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: 'Enter $label',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFB7BFC8),
                    ),
                    suffixIcon: suffixIcon != null
                        ? IconButton(
                      icon: Icon(
                        suffixIcon,
                        color: const Color(0xFF94A3B8),
                        size: 20,
                      ),
                      onPressed: enabled ? onSuffixIconTap : null,
                    ) : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}