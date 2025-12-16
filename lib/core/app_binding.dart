import 'package:edulearn/admin_dashboard/controller/admin_course_controller.dart';
import 'package:edulearn/admin_dashboard/controller/admin_profile_controller.dart';
import 'package:edulearn/admin_dashboard/controller/admin_student_controller.dart';
import 'package:get/get.dart';

import '../../auth/controller/auth_controller.dart';
import '../../student_dashboard/controller/student_controller.dart';
import '../../student_profile/controller/student_profile_controller.dart';
import '../../admin_dashboard/controller/admin_controller.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// 🔐 AUTH (GLOBAL)
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );

    /// 👨‍🎓 STUDENT DASHBOARD
    Get.lazyPut<StudentController>(
      () => StudentController(),
      fenix: true,
    );

    /// 👨‍🎓 STUDENT PROFILE
    Get.lazyPut<StudentProfileController>(
      () => StudentProfileController(),
      fenix: true,
    );

    /// 🛠 ADMIN DASHBOARD
    Get.lazyPut<AdminController>(
      () => AdminController(),
      fenix: true,
    );

    /// 👑 ADMIN PROFILE
    Get.lazyPut<AdminProfileController>(
      () => AdminProfileController(),
      fenix: true,
    );
    Get.lazyPut<AdminCourseController>(
    () => AdminCourseController(),
    fenix: true,);
    Get.lazyPut<AdminStudentController>(
    () => AdminStudentController(),
    fenix: true,);
  }
}
