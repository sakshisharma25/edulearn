import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AdminHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const AdminHeader({
    super.key,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Admin Panel", style: AppTextStyles.heading1),
              const SizedBox(height: 4),
              Text(
                "Manage courses & students",
                style: AppTextStyles.bodySecondary,
              ),
            ],
          ),

          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryLight,
              child: Icon(
                Icons.admin_panel_settings,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
