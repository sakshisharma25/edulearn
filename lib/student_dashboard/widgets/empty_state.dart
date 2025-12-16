import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No courses available yet",
        style: AppTextStyles.bodySecondary,
      ),
    );
  }
}
