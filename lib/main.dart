import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './depedencies.dart';

import './core/theme/light_theme.dart';
import './core/theme/dark_theme.dart';
import './core/cubit/app_theme/app_theme_cubit.dart';

import './router.dart';

Future<void> main() async {
  await initDependencies();

  final appThemeCubit = getIt<AppThemeCubit>();

  appThemeCubit.loadThemeMode();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider.value(value: appThemeCubit)],
      child: const KuvakaTech(),
    ),
  );
}

class KuvakaTech extends StatelessWidget {
  const KuvakaTech({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, appThemeModeState) {
        return MaterialApp.router(
          title: 'Kuvaka Tech Assignment',
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: appThemeModeState.themeMode,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
