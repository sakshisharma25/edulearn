import 'package:edulearn/admin_dashboard/screen/admin_profile_view.dart';
import 'package:edulearn/admin_dashboard/widgets/add_course.dart';
import 'package:edulearn/admin_dashboard/widgets/manage_student_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../student_dashboard/widgets/course_card.dart';
import '../../student_dashboard/widgets/empty_state.dart';
import '../controller/admin_controller.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_action_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.loadCourses,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 🔹 HEADER
              AdminHeader(
                onProfileTap: () {
                  Get.to(AdminProfileView());
                },
              ),

              const SizedBox(height: 24),

              // 🔧 ACTIONS
              AdminActionCard(
                icon: Icons.add_circle_outline,
                title: "Add New Course",
                onTap: () {
                  Get.to(AddCourseView());
                },
              ),
              AdminActionCard(
                icon: Icons.people_outline,
                title: "Manage Students",
                onTap: () {
                  Get.to(ManageStudentsView());
                },
              ),

              const SizedBox(height: 24),

              // 📚 COURSES
              Text(
                "All Courses",
                style: AppTextStyles.heading3,
              ),
              const SizedBox(height: 12),

              controller.courses.isEmpty
                  ? const EmptyState(
                 
                    )
                  : Column(
                      children: controller.courses
                          .map(
                            (course) => CourseCard(course: course),
                          )
                          .toList(),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
