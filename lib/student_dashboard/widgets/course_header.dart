import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_styles.dart';

class CourseHeader extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseHeader({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course['title'] ?? '',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 6),
          Text(
            course['description'] ?? '',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}
