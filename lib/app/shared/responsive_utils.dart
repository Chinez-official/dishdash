import 'package:flutter/widgets.dart';

/// Utility class for creating responsive layouts across different screen sizes.
/// Uses a reference design width of 375dp (iPhone 11 width) as the baseline.
class ResponsiveUtils {
  static const double _designWidth = 375.0;
  static const double _designHeight = 812.0;

  /// Gets the current screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Gets the current screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  /// Scales a width value based on the screen width relative to design width.
  /// Example: wp(150, context) on a 400dp wide screen returns 160dp
  static double wp(double designPixels, BuildContext context) {
    return designPixels * (screenWidth(context) / _designWidth);
  }

  /// Scales a height value based on the screen height relative to design height.
  static double hp(double designPixels, BuildContext context) {
    return designPixels * (screenHeight(context) / _designHeight);
  }

  /// Scales a font size based on screen width for consistent text sizing.
  /// Uses a slightly less aggressive scaling to keep text readable.
  static double sp(double designFontSize, BuildContext context) {
    final scaleFactor = screenWidth(context) / _designWidth;
    // Limit scaling between 0.85x and 1.15x to prevent extreme sizes
    final clampedFactor = scaleFactor.clamp(0.85, 1.15);
    return designFontSize * clampedFactor;
  }

  /// Returns true if the screen is considered "small" (width < 360dp)
  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 360;
  }

  /// Returns true if the screen is considered "large" (width >= 400dp)
  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 400;
  }
}

/// Extension on BuildContext for easier access to responsive utilities
extension ResponsiveContext on BuildContext {
  /// Shorthand for ResponsiveUtils.wp(value, context)
  double wp(double value) => ResponsiveUtils.wp(value, this);

  /// Shorthand for ResponsiveUtils.hp(value, context)
  double hp(double value) => ResponsiveUtils.hp(value, this);

  /// Shorthand for ResponsiveUtils.sp(value, context)
  double sp(double value) => ResponsiveUtils.sp(value, this);

  /// Get screen width
  double get screenWidth => ResponsiveUtils.screenWidth(this);

  /// Get screen height
  double get screenHeight => ResponsiveUtils.screenHeight(this);
}
