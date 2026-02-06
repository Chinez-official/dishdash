import 'package:flutter/material.dart';

/// Device screen type classification
enum DeviceScreenType { phone, tablet }

/// Determines device type based on shortest side of screen
DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;
  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }
  return DeviceScreenType.phone;
}

/// Contains sizing information for responsive layouts
class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  bool get isPhone => deviceScreenType == DeviceScreenType.phone;
  bool get isTablet => deviceScreenType == DeviceScreenType.tablet;

  /// Scale factor based on reference width of 375dp (iPhone 11)
  double get scaleFactor => screenSize.width / 375.0;

  /// Scale a width value proportionally
  double wp(double value) => value * scaleFactor;

  /// Scale a font size with clamping for readability
  double sp(double value) {
    final clampedFactor = scaleFactor.clamp(0.85, 1.2);
    return value * clampedFactor;
  }
}

/// Responsive builder that provides sizing information based on constraints
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  )
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var mediaQuery = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(
            boxConstraints.maxWidth,
            boxConstraints.maxHeight,
          ),
        );
        return builder(context, sizingInformation);
      },
    );
  }
}

/// Wrapper that provides different layouts for phone vs tablet
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Widget? child) phoneBuilder;
  final Widget Function(BuildContext context, Widget? child) tabletBuilder;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    required this.phoneBuilder,
    required this.tabletBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return phoneBuilder(context, child);
        } else {
          return tabletBuilder(context, child);
        }
      },
    );
  }
}

/// Extension on BuildContext for quick access to sizing
extension ResponsiveContext on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Get screen height
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Scale factor based on 375dp reference width
  double get scaleFactor => screenWidth / 375.0;

  /// Shorthand for scaling width values
  double wp(double value) => value * scaleFactor;

  /// Shorthand for scaling font sizes (clamped)
  double sp(double value) {
    final clampedFactor = scaleFactor.clamp(0.85, 1.2);
    return value * clampedFactor;
  }

  /// Check if device is a phone
  bool get isPhone => MediaQuery.sizeOf(this).shortestSide <= 600;

  /// Check if device is a tablet
  bool get isTablet => MediaQuery.sizeOf(this).shortestSide > 600;
}
