import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final Color? color;
  final double? height;

  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
    this.color,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.bottomLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
