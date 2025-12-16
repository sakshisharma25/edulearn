import 'package:edulearn/core/app_binding.dart';
import 'package:edulearn/core/routes/approutes.dart';
import 'package:edulearn/core/routes/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Decide initial route
  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingDone = prefs.getBool('onboarding_completed') ?? false;

    final User? user = FirebaseAuth.instance.currentUser;

    final savedRole = prefs.getString('user_role');

    if (user != null && savedRole != null) {
      if (savedRole == 'admin' || savedRole == 'super_admin') {
        return RouteNames.adminDashboard;
      } else {
        return RouteNames.studentDashboard;
      }
    }

    if (!onboardingDone) {
      return RouteNames.onboarding;
    }

    if (user == null) {
      return RouteNames.auth;
    }

    // Later → role based dashboard
    return RouteNames.auth;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialBinding: AppBindings(),
          initialRoute: RouteNames.splash, // ✅ USE COMPUTED ROUTE
          getPages: AppPages.pages,
        );
      },
    );
  }
}
