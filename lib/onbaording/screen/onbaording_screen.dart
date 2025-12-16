import 'package:edulearn/core/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/app_assets.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: AppAssets.girl,
      title: "Learn Anytime",
      description: "Access free courses and study materials anytime.",
    ),
    _OnboardingData(
      image: AppAssets.teacher,
      title: "Expert Content",
      description: "Videos, PDFs, PPTs and MCQs curated for you.",
    ),
    _OnboardingData(
      image: AppAssets.doubt,
      title: "Solve Your Doubts",
      description: "Learn at your pace and grow your skills.",
    ),
  ];

  /* ----------------------------------------------------
   🔹 SAVE ONBOARDING COMPLETED
  ---------------------------------------------------- */
  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    // Navigate to Auth screen
    Get.offAllNamed(RouteNames.auth);
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ⏭ Skip button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(
                  "Skip",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            // 📖 Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: Responsive.screenPadding(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page.image,
                          height: 220,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading2,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySecondary,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔘 Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index),
              ),
            ),

            const SizedBox(height: 20),

            // ▶ Next / Get Started
            Padding(
              padding: Responsive.screenPadding(context),
              child: AppButton(
                text: _currentIndex == _pages.length - 1
                    ? "Get Started"
                    : "Next",
                onPressed: _nextPage,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentIndex == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? AppColors.primary
            : AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String description;

  _OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
