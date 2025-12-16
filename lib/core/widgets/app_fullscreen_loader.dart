import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_loader.dart';

class AppFullScreenLoader extends StatelessWidget {
  const AppFullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground.withOpacity(0.6),
      child: const AppLoader(
        size: 42,
      ),
    );
  }
}
