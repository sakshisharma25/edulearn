import 'package:flutter/material.dart';

class Responsive {
  // Screen size
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Safe horizontal padding for phones
  static EdgeInsets screenPadding(BuildContext context) {
    return const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    );
  }

  // Button height (consistent across app)
  static double buttonHeight(BuildContext context) => 48;

  // Card radius
  static BorderRadius cardRadius() =>
      BorderRadius.circular(12);

  // Icon size
  static double iconSize() => 22;

  // Text sizes (phone optimized)
  static double titleText() => 22;
  static double subtitleText() => 16;
  static double bodyText() => 14;
  static double captionText() => 12;
}
