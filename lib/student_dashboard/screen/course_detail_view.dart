import 'package:edulearn/student_dashboard/controller/course_detail_controller.dart';
import 'package:edulearn/student_dashboard/widgets/content_tab.dart';
import 'package:edulearn/student_dashboard/widgets/course_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';


class CourseDetailView extends StatelessWidget {
  final String courseId;

  const CourseDetailView({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CourseDetailController(courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Detail"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (controller.course.isEmpty) {
          return const Center(
            child: Text("Course not found"),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseHeader(course: controller.course),
            const Expanded(child: ContentTabs()),
          ],
        );
      }),
    );
  }
}
