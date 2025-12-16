import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.size = 36,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.primary,
          ),
        ),
      ),
    );
  }
}
