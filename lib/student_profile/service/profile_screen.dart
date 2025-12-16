import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controller/student_profile_controller.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  final controller = Get.put(StudentProfileController());

  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  void _fillInitialData(Map<String, dynamic> profile) {
    firstNameCtrl.text = profile['firstName'] ?? '';
    lastNameCtrl.text = profile['lastName'] ?? '';
    phoneCtrl.text = profile['phone'] ?? '';
  }

Future<void> _logout() async {
  final bool? confirm = await Get.dialog<bool>(
    AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Logout",
        style: AppTextStyles.heading3.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style: AppTextStyles.bodySecondary,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      actions: [
        // ❌ Cancel
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            "Cancel",
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),

        // 🚪 Logout
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: AppColors.buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Get.back(result: true),
          child: const Text("Logout"),
        ),
      ],
    ),
    barrierDismissible: false,
  );

  if (confirm == true) {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/auth');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        final profile = controller.profile;
        _fillInitialData(profile);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👤 HEADER
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(
                        Icons.person,
                        size: 42,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profile['email'] ?? '',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 4),
                    Chip(
                      backgroundColor: AppColors.studentBadge,
                      label: const Text(
                        "STUDENT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ✍️ EDITABLE FIELDS
              Text("Personal Details", style: AppTextStyles.heading2),
              const SizedBox(height: 16),

              TextField(
                controller: firstNameCtrl,
                decoration: const InputDecoration(
                  labelText: "First Name",
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: lastNameCtrl,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                ),
              ),

              const SizedBox(height: 24),

              // 💾 SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.updateProfile(
                      firstName: firstNameCtrl.text.trim(),
                      lastName: lastNameCtrl.text.trim(),
                      phone: phoneCtrl.text.trim(),
                    );

                    Get.snackbar(
                      "Updated",
                      "Profile updated successfully",
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                  },
                  child: const Text("Save Changes"),
                ),
              ),

              const SizedBox(height: 32),

              // 🚪 LOGOUT
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: AppColors.error),
                  ),
                  onPressed: _logout,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
