import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hàm tạo page với fade transition
CustomTransitionPage buildFadeTransitionPage(Widget child) {
  return CustomTransitionPage(
    key: ValueKey(child.hashCode),
    child: child,
    transitionDuration: const Duration(milliseconds: 800), //
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Bắt đầu từ ngoài màn hình bên phải
          end: Offset.zero,              // Về vị trí gốc
        ).animate(curvedAnimation),
        child: child,
      );
    },
  );
}
