import 'package:get/get.dart';
import '../service/admin_student_service.dart';

class AdminStudentController extends GetxController {
  final _service = AdminStudentService();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> students = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  Future<void> loadStudents() async {
    try {
      isLoading.value = true;
      students.assignAll(await _service.getStudents());
    } finally {
      isLoading.value = false;
    }
  }
}
