import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(AppColors.primaryDark),
      onPrimary: const Color(AppColors.textPrimaryDark),
      primaryContainer: const Color(AppColors.primaryVariantDark),
      onPrimaryContainer: const Color(AppColors.textPrimaryDark),

      secondary: const Color(AppColors.secondaryDark),
      onSecondary: const Color(AppColors.textPrimaryDark),
      secondaryContainer: const Color(
        AppColors.secondaryDark,
      ).withValues(alpha: 0.1),
      onSecondaryContainer: const Color(AppColors.textPrimaryDark),

      surface: const Color(AppColors.surfaceDark),
      onSurface: const Color(AppColors.textPrimaryDark),

      error: const Color(AppColors.errorDark),
      onError: const Color(AppColors.surfaceDark),

      tertiary: const Color(AppColors.chartAccentDark),
      onTertiary: const Color(AppColors.textPrimaryDark),
    ),
    scaffoldBackgroundColor: const Color(AppColors.backgroundDark),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(AppColors.primaryDark),
      foregroundColor: Color(AppColors.textPrimaryDark),
      elevation: 0,
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
        foregroundColor: const Color(AppColors.surfaceDark),
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
  );
}
