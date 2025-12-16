import 'package:edulearn/student_dashboard/service/student_service.dart';
import 'package:get/get.dart';


class AdminController extends GetxController {
  final CourseService _courseService = CourseService();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> courses = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      isLoading.value = true;
      final data = await _courseService.getCourses();
      courses.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}
