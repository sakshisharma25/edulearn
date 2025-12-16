import 'package:edulearn/student_dashboard/service/student_service.dart';
import 'package:get/get.dart';


class CourseDetailController extends GetxController {
  final CourseService _service = CourseService();

  final String courseId;

  CourseDetailController(this.courseId);

  RxBool isLoading = false.obs;
  RxMap<String, dynamic> course = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCourse();
  }

  Future<void> loadCourse() async {
    try {
      isLoading.value = true;
      final data = await _service.getCourseById(courseId);
      if (data != null) {
        course.assignAll(data);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
