import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(AppColors.primaryLight),
      onPrimary: Colors.white, // White text on primary color
      primaryContainer: const Color(AppColors.primaryVariantLight),
      onPrimaryContainer: Colors.white, // White text on primary container

      secondary: const Color(AppColors.secondaryLight),
      onSecondary: Colors.white, // White text on secondary color
      secondaryContainer: const Color(
        AppColors.secondaryLight,
      ).withValues(alpha: 0.1),
      onSecondaryContainer: const Color(AppColors.textPrimaryLight),

      surface: const Color(AppColors.surfaceLight),
      onSurface: const Color(AppColors.textPrimaryLight),

      error: const Color(AppColors.errorLight),
      onError: Colors.white, // White text on error color

      tertiary: const Color(AppColors.chartAccentLight),
      onTertiary: Colors.white, // White text on tertiary color
    ),
    scaffoldBackgroundColor: const Color(AppColors.backgroundLight),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(AppColors.primaryLight),
      foregroundColor: Colors.white, // White text/icons on AppBar
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(AppColors.textPrimaryLight),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.textPrimaryLight),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(AppColors.textSecondaryLight),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(AppColors.textSecondaryLight),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(AppColors.primaryLight),
        foregroundColor: Colors.white, // White text on buttons
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(AppColors.surfaceLight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dividerColor: const Color(AppColors.dividerLight),
    cardTheme: CardThemeData(
      color: const Color(AppColors.surfaceLight),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(AppColors.primaryLight),
      foregroundColor: Colors.white,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(
        AppColors.primaryLight,
      ).withValues(alpha: 0.1),
      labelStyle: const TextStyle(color: Color(AppColors.primaryLight)),
      secondaryLabelStyle: const TextStyle(
        color: Color(AppColors.secondaryLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
