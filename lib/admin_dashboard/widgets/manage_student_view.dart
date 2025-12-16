import 'package:edulearn/admin_dashboard/controller/admin_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ManageStudentsView extends StatelessWidget {
  final controller = Get.put(AdminStudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Students")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (_, i) {
            final s = controller.students[i];
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(s['email']),
              subtitle: Text("${s['firstName'] ?? ''} ${s['lastName'] ?? ''}"),
            );
          },
        );
      }),
    );
  }
}
