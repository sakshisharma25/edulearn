import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../controller/admin_profile_controller.dart';

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({super.key});

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  final controller = Get.put(AdminProfileController());

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  void _fillData(Map<String, dynamic> profile) {
    firstNameCtrl.text = profile['firstName'] ?? '';
    lastNameCtrl.text = profile['lastName'] ?? '';
    phoneCtrl.text = profile['phone'] ?? '';
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Profile"),
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
        _fillData(profile);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 👑 HEADER
              const CircleAvatar(
                radius: 42,
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  Icons.admin_panel_settings,
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
                backgroundColor: AppColors.adminBadge,
                label: const Text(
                  "ADMIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 32),

              // ✍️ EDIT FORM
              TextField(
                controller: firstNameCtrl,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lastNameCtrl,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone"),
              ),

              const SizedBox(height: 24),

              // 💾 SAVE
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
