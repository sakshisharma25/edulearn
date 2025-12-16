import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';
import 'app_loader.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? height;
  final double? radius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Responsive.buttonHeight(context),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? AppColors.primary : AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(radius ?? 10),
          ),
        ),
        child: isLoading
            ? const AppLoader(
                size: 20,
                strokeWidth: 2,
              )
            : Text(
                text,
                style: AppTextStyles.button,
              ),
      ),
    );
  }
}
