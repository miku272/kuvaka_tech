import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/service/sf_service.dart';
import './core/cubit/app_theme/app_theme_cubit.dart';
import './core/service/hive_service.dart';
import './core/model/transaction.dart';
import './core/model/budget.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initsfService();
  _initHiveService();

  _initAppTheme();
}

Future<void> _initsfService() async {
  final sharedPref = await SharedPreferences.getInstance();

  final sfService = SfService(sharedPreferences: sharedPref);

  getIt.registerLazySingleton<SfService>(() => sfService);
}

Future<void> _initHiveService() async {
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(BudgetAdapter());

  // Open separate boxes for each model
  final transactionsBox = await Hive.openBox<Transaction>('transactionsBox');
  final budgetsBox = await Hive.openBox<Budget>('budgetsBox');

  final hiveService = HiveService(
    transactionsBox: transactionsBox,
    budgetsBox: budgetsBox,
  );

  getIt.registerLazySingleton<HiveService>(() => hiveService);
}

void _initAppTheme() {
  getIt.registerLazySingleton(
    () => AppThemeCubit(sfService: getIt<SfService>()),
  );
}
