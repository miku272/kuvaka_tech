import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/service/sf_service.dart';
import './core/cubit/app_theme/app_theme_cubit.dart';
import './core/service/hive_service.dart';
import './core/model/transaction.dart';
import './core/model/budget.dart';

import './features/dashboard/data/datasource/dashboard_local_datasource.dart';
import './features/dashboard/domain/repository/dashboard_repository.dart';
import './features/dashboard/data/repository/dashboard_repository_impl.dart';
import './features/dashboard/presentation/bloc/dashboard_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initsfService();
  await _initHiveService();

  _initAppTheme();
  _initDashboard();
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

  getIt.registerLazySingleton<Box<Transaction>>(() => transactionsBox);
  getIt.registerLazySingleton<Box<Budget>>(() => budgetsBox);

  final hiveService = HiveService(
    transactionsBox: getIt<Box<Transaction>>(),
    budgetsBox: getIt<Box<Budget>>(),
  );

  getIt.registerLazySingleton<HiveService>(() => hiveService);
}

void _initAppTheme() {
  getIt.registerLazySingleton(
    () => AppThemeCubit(sfService: getIt<SfService>()),
  );
}

void _initDashboard() {
  getIt.registerFactory<DashboardLocalDatasource>(
    () => DashboardLocalDatasourceImpl(
      transactionBox: getIt<Box<Transaction>>(),
      budgetBox: getIt<Box<Budget>>(),
    ),
  );

  getIt.registerFactory<DashboardRepository>(
    () => DashboardRepositoryImpl(
      dashboardLocalDatasource: getIt<DashboardLocalDatasource>(),
    ),
  );

  getIt.registerLazySingleton<DashboardBloc>(
    () => DashboardBloc(dashboardRepository: getIt<DashboardRepository>()),
  );
}
