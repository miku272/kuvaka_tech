import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SfService {
  final SharedPreferences _sharedPreferences;

  static const String themeModeKey = 'theme_mode';

  SfService({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _sharedPreferences.setString(themeModeKey, themeMode.name);
  }

  ThemeMode getThemeMode() {
    final themeModeString = _sharedPreferences.getString(themeModeKey);

    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<bool> clearThemeMode() async {
    return await _sharedPreferences.remove(themeModeKey);
  }
}
