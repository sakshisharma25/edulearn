import 'package:edulearn/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/app_snackbar.dart';
import '../controller/auth_controller.dart';

enum AuthMode { login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController controller = Get.put(AuthController());

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  AuthMode _mode = AuthMode.login;
  String _selectedRole = 'student';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: Responsive.screenPadding(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔐 Title
                const SizedBox(height: 8),
                Image.asset(
                  AppAssets.logowithoutbg, // or AppAssets.logo
                  height: 150,
                ),
                Text(
                  _mode == AuthMode.login ? "Login" : "Create Account",
                  style: AppTextStyles.heading1,
                ),

                const SizedBox(height: 8),

                Text(
                  _mode == AuthMode.login
                      ? "Login to continue"
                      : "Sign up to get started",
                  style: AppTextStyles.bodySecondary,
                ),

                const SizedBox(height: 32),

                // 📧 Email
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),

                const SizedBox(height: 12),

                // 🔒 Password
                TextField(
                  controller: passCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                if (_mode == AuthMode.login)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await controller.forgotPassword(
                            emailCtrl.text.trim(),
                          );

                          AppSnackbar.show(
                            context,
                            title: "Reset Email Sent",
                            message: "Check your email to reset your password",
                          );
                        } catch (e) {
                          AppSnackbar.show(
                            context,
                            title: "Error",
                            message: e.toString(),
                          );
                        }
                      },
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                // 🔁 CONFIRM PASSWORD (SIGNUP ONLY)
                if (_mode == AuthMode.signup) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmPassCtrl,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // 👤 Role Selector (ONLY FOR SIGNUP)
// 👤 Role Selector (ONLY FOR SIGNUP)
                if (_mode == AuthMode.signup)
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                    ),
                    dropdownColor: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(14),
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.border,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'student',
                        child: Text("Student"),
                      ),
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text("Admin"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedRole = value!);
                    },
                  ),

                const SizedBox(height: 24),

                // 🔘 Login / Signup Button
                Obx(
                  () => AppButton(
                    text: _mode == AuthMode.login ? "Login" : "Sign Up",
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      try {
                        // 🔐 VALIDATION FOR SIGNUP
                        if (_mode == AuthMode.signup) {
                          if (passCtrl.text != confirmPassCtrl.text) {
                            AppSnackbar.show(
                              context,
                              title: "Password Mismatch",
                              message:
                                  "Password and confirm password must match.",
                            );
                            return;
                          }
                        }

                        if (_mode == AuthMode.login) {
                          await controller.login(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text.trim(),
                          );

                          AppSnackbar.show(
                            context,
                            message: "Login successful",
                          );
                        } else {
                          await controller.register(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text.trim(),
                            role: _selectedRole,
                          );

                          AppSnackbar.show(
                            context,
                            title: "Verify Email",
                            message: "Verification link sent to your email.",
                          );

                          setState(() => _mode = AuthMode.login);
                        }
                      } catch (e) {
                        AppSnackbar.show(
                          context,
                          title: "Error",
                          message: e.toString(),
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // 🔁 Switch Login / Signup
                TextButton(
                  onPressed: () {
                    setState(() {
                      _mode = _mode == AuthMode.login
                          ? AuthMode.signup
                          : AuthMode.login;
                    });
                  },
                  child: Text(
                    _mode == AuthMode.login
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🌐 Google Sign In (LOGIN ONLY)
                if (_mode == AuthMode.login)
                  AppButton(
                    text: "Continue with Google",
                    onPressed: () async {
                      try {
                        await controller.loginWithGoogle();
                        AppSnackbar.show(
                          context,
                          message: "Google login successful",
                        );
                      } catch (e) {
                        AppSnackbar.show(
                          context,
                          title: "Error",
                          message: "Google login failed",
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
