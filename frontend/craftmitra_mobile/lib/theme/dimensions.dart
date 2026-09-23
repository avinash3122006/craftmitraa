import 'package:flutter/material.dart';

/// Design System Spacing, Elevation, and Radii tokens for CraftMitra AI
class AppDimensions {
  // Spacing (4px / 8px scale rhythm)
  static const double gutter = 16.0;
  static const double margin = 16.0;

  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;

  // Corner Radii (Shape Level 2 friendly rounded geometry)
  static const double radiusSm = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 9999.0;

  // Touch Target Minimums (Accessible in rural / field environments)
  static const double minTouchTarget = 48.0;
  static const double minCheckboxSize = 24.0;

  // BorderRadius Helpers
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius roundedDefault = BorderRadius.all(Radius.circular(radiusDefault));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius roundedFull = BorderRadius.all(Radius.circular(radiusFull));

  // Edge Insets Helpers
  static const EdgeInsets paddingPage = EdgeInsets.symmetric(horizontal: margin, vertical: spaceMd);
  static const EdgeInsets paddingCard = EdgeInsets.all(spaceMd);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(horizontal: spaceLg, vertical: spaceSm);
}
