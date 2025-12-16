import 'package:edulearn/admin_dashboard/screen/admin_dashboard_screen.dart';
import 'package:edulearn/core/routes/route.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // 🔄 Loading state
  RxBool isLoading = false.obs;

  // 👤 Firebase user
  Rx<User?> firebaseUser = Rx<User?>(null);

  // 🧑 Role: super_admin | admin | student
  RxString role = 'student'.obs;

  /* ----------------------------------------------------
   🔹 REGISTER (EMAIL + PASSWORD + ROLE)
  ---------------------------------------------------- */
  Future<void> register({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      isLoading.value = true;

      final user = await _authService.registerWithEmail(
        email: email,
        password: password,
        role: role,
      );

      firebaseUser.value = user;
    } on FirebaseAuthException catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  /* ----------------------------------------------------
   🔹 LOGIN WITH EMAIL (ONLY IF VERIFIED)
  ---------------------------------------------------- */
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final user = await _authService.loginWithEmail(
        email: email,
        password: password,
      );

      if (user != null) {
        firebaseUser.value = user;

        // Fetch role from Firestore
        final fetchedRole =
            await _authService.getUserRole(user.uid);

        role.value = fetchedRole;
        role.value = await _authService.getUserRole(user.uid);
        await _saveSession(role.value);

          handlePostLoginNavigation();
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }
  
  void handlePostLoginNavigation() {

  if (isAdmin) {
      Get.offAllNamed(RouteNames.adminDashboard);
    } else {
      // 👨‍🎓 Student (default)
      Get.offAllNamed(RouteNames.studentDashboard);
    }
  }
Future<void> _saveSession(String role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_role', role);
}
    Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      throw FirebaseAuthException(
        code: 'email-required',
        message: 'Please enter your email address',
      );
    }

    await _authService.sendPasswordResetEmail(email);
  }
  /* ----------------------------------------------------
   🔹 GOOGLE SIGN-IN
  ---------------------------------------------------- */
Future<void> loginWithGoogle() async {
  try {
    isLoading.value = true;

    final user = await _authService.signInWithGoogle();

    if (user != null) {
      firebaseUser.value = user;

      final fetchedRole =
          await _authService.getUserRole(user.uid);

      role.value = fetchedRole;

      handlePostLoginNavigation(); // ❗ REQUIRED
    }
  } finally {
    isLoading.value = false;
  }
}


  /* ----------------------------------------------------
   🔹 RESEND EMAIL VERIFICATION
  ---------------------------------------------------- */
  Future<void> resendVerificationEmail() async {
    await _authService.resendVerificationEmail();
  }

  /* ----------------------------------------------------
   🔹 LOGOUT
  ---------------------------------------------------- */
  Future<void> logout() async {
    await _authService.logout();
    firebaseUser.value = null;
    role.value = 'student';
  }

  /* ----------------------------------------------------
   🔹 HELPERS
  ---------------------------------------------------- */
  bool get isLoggedIn => firebaseUser.value != null;

  bool get isEmailVerified =>
      firebaseUser.value?.emailVerified ?? false;

  bool get isSuperAdmin => role.value == 'super_admin';
  bool get isAdmin => role.value == 'admin';
  bool get isStudent => role.value == 'student';
}
