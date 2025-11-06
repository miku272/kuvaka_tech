import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/sf_service.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  final SfService _sfService;

  AppThemeCubit({required SfService sfService})
    : _sfService = sfService,
      super(const AppTheme());

  void loadThemeMode() {
    final themeMode = _sfService.getThemeMode();

    emit(AppTheme(themeMode: themeMode));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _sfService.saveThemeMode(themeMode);

    emit(AppTheme(themeMode: themeMode));
  }
}
