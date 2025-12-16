import 'package:edulearn/student_dashboard/controller/student_controller.dart';
import 'package:edulearn/student_dashboard/widgets/course_card.dart';
import 'package:edulearn/student_dashboard/widgets/empty_state.dart';
import 'package:edulearn/student_dashboard/widgets/student_header.dart';
import 'package:edulearn/student_profile/service/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      // ❌ Optional: you can remove AppBar title if you want a cleaner UI
      appBar: AppBar(
        title: const Text("Student Dashboard"),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Header with profile icon
            StudentHeader(
              onProfileTap: () {
                Get.to(StudentProfileView()); // adjust route if needed
              },
            ),

            Expanded(
              child: controller.courses.isEmpty
                  ? const EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: controller.courses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          course: controller.courses[index],
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
