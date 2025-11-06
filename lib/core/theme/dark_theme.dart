import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(AppColors.primaryDark),
      onPrimary: const Color(
        AppColors.backgroundDark,
      ), // Dark text on light primary
      primaryContainer: const Color(AppColors.primaryVariantDark),
      onPrimaryContainer: const Color(
        AppColors.backgroundDark,
      ), // Dark text on light container

      secondary: const Color(AppColors.secondaryDark),
      onSecondary: const Color(
        AppColors.backgroundDark,
      ), // Dark text on light secondary
      secondaryContainer: const Color(
        AppColors.secondaryDark,
      ).withValues(alpha: 0.1),
      onSecondaryContainer: const Color(AppColors.textPrimaryDark),

      surface: const Color(AppColors.surfaceDark),
      onSurface: const Color(AppColors.textPrimaryDark),

      error: const Color(AppColors.errorDark),
      onError: const Color(
        AppColors.backgroundDark,
      ), // Dark text on light error

      tertiary: const Color(AppColors.chartAccentDark),
      onTertiary: const Color(
        AppColors.backgroundDark,
      ), // Dark text on light tertiary
    ),
    scaffoldBackgroundColor: const Color(AppColors.backgroundDark),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(AppColors.primaryDark),
      foregroundColor: Color(
        AppColors.backgroundDark,
      ), // Dark text on light AppBar
      elevation: 0,
      iconTheme: IconThemeData(color: Color(AppColors.backgroundDark)),
      titleTextStyle: TextStyle(
        color: Color(AppColors.backgroundDark),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(AppColors.textPrimaryDark),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.textPrimaryDark),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(AppColors.textSecondaryDark),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(AppColors.textSecondaryDark),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(AppColors.primaryDark),
        foregroundColor: const Color(
          AppColors.backgroundDark,
        ), // Dark text on light buttons
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(AppColors.surfaceDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dividerColor: const Color(AppColors.dividerDark),
    cardTheme: CardThemeData(
      color: const Color(AppColors.surfaceDark),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(AppColors.primaryDark),
      foregroundColor: Color(AppColors.backgroundDark),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(
        AppColors.primaryDark,
      ).withValues(alpha: 0.2),
      labelStyle: const TextStyle(color: Color(AppColors.primaryDark)),
      secondaryLabelStyle: const TextStyle(
        color: Color(AppColors.secondaryDark),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
