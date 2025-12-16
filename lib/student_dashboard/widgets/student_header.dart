import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class StudentHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const StudentHeader({
    super.key,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👋 Welcome text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome 👋",
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: 4),
              Text(
                "Explore free learning resources",
                style: AppTextStyles.bodySecondary,
              ),
            ],
          ),

          // 👤 Profile Avatar
          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryLight,
              child: Icon(
                Icons.person,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
