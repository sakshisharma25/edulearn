import 'package:edulearn/admin_dashboard/screen/admin_dashboard_screen.dart';
import 'package:edulearn/auth/screen/auth_screen.dart';
import 'package:edulearn/core/routes/route.dart';
import 'package:edulearn/onbaording/screen/onbaording_screen.dart';
import 'package:edulearn/onbaording/screen/spalsh_page.dart';
import 'package:edulearn/student_dashboard/screen/student_dashboard.dart';
// Add this
import 'package:get/get.dart';
import 'package:flutter/material.dart';



class AppPages {
  static final pages = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: RouteNames.auth,
      page: () => const AuthScreen(),
    ),

    GetPage(
      name: RouteNames.adminDashboard,
      page: () => const AdminDashboard(),
    ),
    GetPage(
      name: RouteNames.studentDashboard,
      page: () => const StudentDashboard(),
    ),
  ];
}