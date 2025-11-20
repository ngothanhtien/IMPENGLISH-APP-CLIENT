import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CountdownTimerWidget extends StatefulWidget {
  final int minutes; // số phút muốn đếm ngược
  final VoidCallback? onComplete; // callback khi kết thúc
  final double size; // kích thước đồng hồ (mặc định 150)

  const CountdownTimerWidget({
    super.key,
    required this.minutes,
    this.onComplete,
    this.size = 80,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late CountDownController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    final int totalSeconds = widget.minutes * 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularCountDownTimer(
          duration: totalSeconds,
          initialDuration: 0,
          controller: _controller,
          width: widget.size,
          height: widget.size,
          ringColor: Colors.grey.shade300,
          fillGradient: const LinearGradient(
            colors: [Color(0xFF1DD616), Color(0xFF2CF117), Color(0xFF1ED508)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          strokeWidth: 4,
          strokeCap: StrokeCap.round,
          textStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
          textFormat: CountdownTextFormat.MM_SS,
          isReverse: true,
          isReverseAnimation: true,
          autoStart: true,
          onComplete: widget.onComplete ?? () {},
          fillColor: Colors.white,
        ),
      ],
    );
  }
}
