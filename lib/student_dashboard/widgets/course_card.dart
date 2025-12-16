import 'package:edulearn/student_dashboard/screen/course_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';


class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          course['title'] ?? 'Untitled Course',
          style: AppTextStyles.heading3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            course['description'] ?? 'No description available',
            style: AppTextStyles.bodySecondary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primary,
        ),
        onTap: () {
          // 🔥 Navigate to Course Detail
          Get.to(
            () => CourseDetailView(
              courseId: course['id'], // 🔑 Firestore document ID
            ),
          );
        },
      ),
    );
  }
}
