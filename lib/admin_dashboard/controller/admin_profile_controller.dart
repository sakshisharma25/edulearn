import 'package:get/get.dart';
import '../service/admin_profile_service.dart';

class AdminProfileController extends GetxController {
  final AdminProfileService _service = AdminProfileService();

  RxBool isLoading = false.obs;
  RxMap<String, dynamic> profile = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final data = await _service.fetchProfile();
      if (data != null) {
        profile.assignAll(data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // 🔧 PATCH PROFILE
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    try {
      isLoading.value = true;

      await _service.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );

      await loadProfile();
    } finally {
      isLoading.value = false;
    }
  }
}
