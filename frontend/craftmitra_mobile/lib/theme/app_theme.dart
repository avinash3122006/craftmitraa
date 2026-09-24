import 'package:flutter/material.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'typography.dart';

/// AppTheme for CraftMitra AI
/// Incorporates warm cream background, terracotta primary CTA, forest green
/// verified accents, saffron highlights, pure white 16px rounded cards,
/// and 48px accessible touch targets.
class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceDim: AppColors.surfaceDim,
      surfaceBright: AppColors.surfaceBright,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.surfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.onSurface),
        titleTextStyle: AppTypography.headlineSm,
      ),

      // Card Theme (Pure white against warm cream, 16px radius)
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.roundedLg,
          side: const BorderSide(color: AppColors.surfaceContainer, width: 1),
        ),
      ),

      // Elevated Buttons (Terracotta orange, min height 48px, 16px radius)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terracotta,
          foregroundColor: AppColors.pureWhite,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppDimensions.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.roundedLg,
          ),
          textStyle: AppTypography.labelLg.copyWith(
            color: AppColors.pureWhite,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLg,
            vertical: AppDimensions.spaceSm,
          ),
        ),
      ),

      // Outlined Buttons (Forest green or dark charcoal, 16px radius)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.tertiary,
          minimumSize: const Size(double.infinity, AppDimensions.minTouchTarget),
          side: const BorderSide(color: AppColors.forestGreen, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.roundedLg,
          ),
          textStyle: AppTypography.labelLg.copyWith(
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLg,
            vertical: AppDimensions.spaceSm,
          ),
        ),
      ),

      // Text Buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.terracotta,
          minimumSize: const Size(48, AppDimensions.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.roundedDefault,
          ),
          textStyle: AppTypography.labelMd.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Fields (Clean white background, subtle border, 2px terracotta focus)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.pureWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceMd,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        labelStyle: AppTypography.labelMd.copyWith(
          color: AppColors.darkCharcoal,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.roundedLg,
          borderSide: const BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.roundedLg,
          borderSide: const BorderSide(color: AppColors.terracotta, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.roundedLg,
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.roundedLg,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      // Chips & Tags (Pills with soft warm saffron or neutral tint)
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceContainerLow,
        selectedColor: AppColors.secondaryFixed,
        labelStyle: AppTypography.labelSm,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.roundedFull,
          side: const BorderSide(color: Colors.transparent),
        ),
      ),

      // Checkbox Theme (Oversized touch targets with forest green active state)
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.forestGreen;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.roundedSm,
        ),
        side: const BorderSide(color: AppColors.outline, width: 1.5),
      ),

      // Radio Theme (Forest green)
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.forestGreen;
          }
          return AppColors.outline;
        }),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceContainerHighest,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.pureWhite,
        selectedItemColor: AppColors.terracotta,
        unselectedItemColor: AppColors.onSurfaceVariant,
        selectedLabelStyle: AppTypography.labelSm,
        unselectedLabelStyle: AppTypography.labelSm,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
