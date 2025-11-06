import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(AppColors.primaryLight),
      onPrimary: const Color(AppColors.textPrimaryLight),
      primaryContainer: const Color(AppColors.primaryVariantLight),
      onPrimaryContainer: const Color(AppColors.textPrimaryLight),

      secondary: const Color(AppColors.secondaryLight),
      onSecondary: const Color(AppColors.textPrimaryLight),
      secondaryContainer: const Color(
        AppColors.secondaryLight,
      ).withValues(alpha: 0.1),
      onSecondaryContainer: const Color(AppColors.textPrimaryLight),

      surface: const Color(AppColors.surfaceLight),
      onSurface: const Color(AppColors.textPrimaryLight),

      error: const Color(AppColors.errorLight),
      onError: const Color(AppColors.surfaceLight),

      tertiary: const Color(AppColors.chartAccentLight),
      onTertiary: const Color(AppColors.textPrimaryLight),
    ),
    scaffoldBackgroundColor: const Color(AppColors.backgroundLight),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(AppColors.primaryLight),
      foregroundColor: Color(AppColors.textPrimaryLight),
      elevation: 0,
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
        foregroundColor: const Color(AppColors.surfaceLight),
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
  );
}
