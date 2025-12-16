import 'package:get/get.dart';
import '../service/admin_course_service.dart';

class AdminCourseController extends GetxController {
  final AdminCourseService _service = AdminCourseService();

  RxBool isLoading = false.obs;

  /// MCQs list
  RxList<Map<String, dynamic>> mcqs = <Map<String, dynamic>>[].obs;

  void addMcq({
    required String question,
    required List<String> options,
    required String answer,
  }) {
    mcqs.add({
      'question': question,
      'options': options,
      'answer': answer,
    });
  }

  void removeMcq(int index) {
    mcqs.removeAt(index);
  }

  Future<void> addCourse({
    required String title,
    required String description,
    required String videoUrl,
    required String pdfUrl,
  }) async {
    try {
      isLoading.value = true;

      await _service.addCourse(
        title: title,
        description: description,
        videoUrl: videoUrl,
        pdfUrl: pdfUrl,
        mcqs: mcqs,
      );

      mcqs.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
