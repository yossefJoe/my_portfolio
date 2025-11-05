import 'package:flutter/material.dart';
import 'app_colors.dart';
import '../utils/responsive.dart';

class AppTextStyles {
  AppTextStyles._();

  /// 🧠 Helper function لتحديد الحجم حسب الشاشة
  static double _scale(BuildContext context, double baseSize) {
    if (Responsive.isDesktop(context)) return baseSize * 1.3;
    if (Responsive.isTablet(context)) return baseSize * 1.15;
    return baseSize;
  }

  // 🏷️ Headings
  static TextStyle heading1(BuildContext context) => TextStyle(
        fontSize: _scale(context, 32),
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle heading2(BuildContext context) => TextStyle(
        fontSize: _scale(context, 26),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle heading3(BuildContext context) => TextStyle(
        fontSize: _scale(context, 22),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // 📝 Body Text
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: _scale(context, 18),
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontSize: _scale(context, 16),
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: _scale(context, 14),
        color: AppColors.textSecondary,
      );

  // 🔘 Buttons
  static TextStyle button(BuildContext context) => TextStyle(
        fontSize: _scale(context, 16),
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        letterSpacing: 0.5,
      );

  // 💬 Captions / Labels
  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: _scale(context, 12),
        color: AppColors.textSecondary,
      );
}
