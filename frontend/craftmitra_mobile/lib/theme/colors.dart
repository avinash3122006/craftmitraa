import 'package:flutter/material.dart';

/// Complete Design System Color Palette for CraftMitra AI
/// Built for cultural authenticity, rural accessibility, and high contrast.
class AppColors {
  // Brand Earth Pigments & Accents
  static const Color terracotta = Color(0xFFD95325);
  static const Color warmSaffron = Color(0xFFF0A500);
  static const Color forestGreen = Color(0xFF2E6F40);
  static const Color warmCream = Color(0xFFFAF8F5);
  static const Color darkCharcoal = Color(0xFF222222);
  static const Color pureWhite = Color(0xFFFFFFFF);

  // Material 3 Tokens from Design Specification
  static const Color primary = Color(0xFFA93101);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFCB491B);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color inversePrimary = Color(0xFFFFB59E);

  static const Color secondary = Color(0xFF805600);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFB21D);
  static const Color onSecondaryContainer = Color(0xFF6B4800);

  static const Color tertiary = Color(0xFF27683A);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF418251);
  static const Color onTertiaryContainer = Color(0xFFF7FFF3);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color background = Color(0xFFFBF9F6);
  static const Color onBackground = Color(0xFF1B1C1A);

  static const Color surface = Color(0xFFFBF9F6);
  static const Color onSurface = Color(0xFF1B1C1A);
  static const Color surfaceDim = Color(0xFFDBDAD7);
  static const Color surfaceBright = Color(0xFFFBF9F6);
  static const Color surfaceVariant = Color(0xFFE4E2DF);
  static const Color onSurfaceVariant = Color(0xFF59413A);

  // Surface Containers (Tonal Layering)
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3F0);
  static const Color surfaceContainer = Color(0xFFEFEEEB);
  static const Color surfaceContainerHigh = Color(0xFFEAE8E5);
  static const Color surfaceContainerHighest = Color(0xFFE4E2DF);

  static const Color inverseSurface = Color(0xFF30312F);
  static const Color inverseOnSurface = Color(0xFFF2F0ED);

  static const Color outline = Color(0xFF8D7169);
  static const Color outlineVariant = Color(0xFFE1BFB5);
  static const Color surfaceTint = Color(0xFFAC3403);

  // Fixed Roles
  static const Color primaryFixed = Color(0xFFFFDBD0);
  static const Color primaryFixedDim = Color(0xFFFFB59E);
  static const Color onPrimaryFixed = Color(0xFF3A0B00);
  static const Color onPrimaryFixedVariant = Color(0xFF842400);

  static const Color secondaryFixed = Color(0xFFFFDDAF);
  static const Color secondaryFixedDim = Color(0xFFFFBA44);
  static const Color onSecondaryFixed = Color(0xFF281800);
  static const Color onSecondaryFixedVariant = Color(0xFF614000);

  static const Color tertiaryFixed = Color(0xFFADF3B8);
  static const Color tertiaryFixedDim = Color(0xFF92D69D);
  static const Color onTertiaryFixed = Color(0xFF00210B);
  static const Color onTertiaryFixedVariant = Color(0xFF0A5226);

  // Ambient Shadows
  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromRGBO(34, 34, 34, 0.08),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  static const BoxShadow pressedShadow = BoxShadow(
    color: Color.fromRGBO(34, 34, 34, 0.04),
    blurRadius: 4,
    offset: Offset(0, 2),
  );
}
