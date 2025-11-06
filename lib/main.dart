import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './depedencies.dart';

import './core/theme/light_theme.dart';
import './core/theme/dark_theme.dart';
import './core/cubit/app_theme/app_theme_cubit.dart';

import './router.dart';

import './features/dashboard/presentation/bloc/dashboard_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  final appThemeCubit = getIt<AppThemeCubit>();

  appThemeCubit.loadThemeMode();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: appThemeCubit),
        BlocProvider(create: (context) => getIt<DashboardBloc>()),
      ],
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
          debugShowCheckedModeBanner: false,
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: appThemeModeState.themeMode,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
