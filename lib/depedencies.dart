import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/service/sf_service.dart';
import 'core/cubit/app_theme/app_theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initsfService();
  _initAppTheme();
}

Future<void> _initsfService() async {
  final sharedPref = await SharedPreferences.getInstance();

  final sfService = SfService(sharedPreferences: sharedPref);

  getIt.registerLazySingleton<SfService>(() => sfService);
}

void _initAppTheme() {
  getIt.registerLazySingleton(
    () => AppThemeCubit(sfService: getIt<SfService>()),
  );
}
