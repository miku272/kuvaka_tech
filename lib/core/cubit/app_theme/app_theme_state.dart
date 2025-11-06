part of 'app_theme_cubit.dart';

@immutable
sealed class AppThemeState {
  final ThemeMode themeMode;

  const AppThemeState({this.themeMode = ThemeMode.system});
}

final class AppTheme extends AppThemeState {
  const AppTheme({super.themeMode = ThemeMode.system});
}
