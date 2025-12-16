import 'dart:async';
import 'package:edulearn/core/app_assets.dart';
import 'package:edulearn/core/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Show splash for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Get user preferences and auth state
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingDone = prefs.getBool('onboarding_completed') ?? false;
    final User? user = FirebaseAuth.instance.currentUser;
    final savedRole = prefs.getString('user_role');

    // Determine route based on user state
    String route;

    if (user != null && savedRole != null) {
      // User is logged in with a role
      if (savedRole == 'admin' || savedRole == 'super_admin') {
        route = RouteNames.adminDashboard;
      } else {
        route = RouteNames.studentDashboard;
      }
    } else if (!onboardingDone) {
      // First time user - show onboarding
      route = RouteNames.onboarding;
    } else {
      // Returning user but not logged in
      route = RouteNames.auth;
    }

    // Navigate using GetX (removes all previous routes from stack)
    Get.offAllNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: Padding(
          padding: Responsive.screenPadding(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔰 App Logo
              Image.asset(
                AppAssets.logowithoutbg,
                height: 200,
              ),

              const SizedBox(height: 20),

              // 🏷 App Name
              Text(
                "EduLearn",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 8),

              // ✨ Tagline
              Text(
                "Learn Anytime, Anywhere",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 40),

              // 🔄 Loading Indicator (optional)
              const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}