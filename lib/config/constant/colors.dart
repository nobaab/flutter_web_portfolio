import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF7C3AED); // Purple from the floating action button
  static const Color secondary = Color(0xFFEAB308); // Yellow from the chip

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color cardColor = Color(0xFFE6EEF3);
  static const Color blueDark = Color(0xFF1D2224);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF9FAFB);

  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Specific Design Colors
  static const Color chipSelectedBackground = Color(0xFFEAB308);
  static const Color chipUnselectedBackground = Color(0xFFF3F4F6);
  static const Color notificationDot = Color(0xFFEF4444);
  static const Color chipColor = Color(0xFFF3F9FD);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
