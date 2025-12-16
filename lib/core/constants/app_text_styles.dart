import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 🏷 App Title / Large Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // 🔹 Section Headings
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // 🔸 Sub Heading
  static const TextStyle heading3 = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // 📄 Body Text (Normal)
  static const TextStyle body = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // 📄 Secondary / Description Text
  static const TextStyle bodySecondary = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ✍️ Small Text / Hint
  static const TextStyle caption = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // 🔘 Button Text
  static const TextStyle button = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // ❌ Error Text
  static const TextStyle error = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  // ✅ Success Text
  static const TextStyle success = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );
}
