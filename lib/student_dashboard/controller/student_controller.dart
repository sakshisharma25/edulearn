import 'package:edulearn/student_dashboard/service/student_service.dart';
import 'package:get/get.dart';


class StudentController extends GetxController {
  final CourseService _courseService = CourseService();

  // 🔄 Loading state
  RxBool isLoading = false.obs;

  // 📚 List of courses
  RxList<Map<String, dynamic>> courses = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  /// 🔹 Load all courses from Firestore
  Future<void> loadCourses() async {
    try {
      isLoading.value = true;

      final List<Map<String, dynamic>> data =
          await _courseService.getCourses();

      courses.assignAll(data);
    } catch (e) {
      // In case of error, clear list
      courses.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔹 Refresh courses manually (pull-to-refresh later)
  Future<void> refreshCourses() async {
    await loadCourses();
  }
}
