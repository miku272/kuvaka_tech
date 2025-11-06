import 'package:fpdart/fpdart.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/model/budget.dart';

import '../../../../core/model/transaction.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasource/dashboard_local_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDatasource _dashboardLocalDatasource;

  DashboardRepositoryImpl({
    required DashboardLocalDatasource dashboardLocalDatasource,
  }) : _dashboardLocalDatasource = dashboardLocalDatasource;

  @override
  Either<Failure, List<Budget>> getBudgets() {
    try {
      return right(_dashboardLocalDatasource.getBudgets());
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Either<Failure, Map<String, double>> getExpensesByCategory() {
    try {
      return right(_dashboardLocalDatasource.getExpenseByCategory());
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Either<Failure, Map<String, double>> getIncomeExpensesTotal() {
    try {
      return right(_dashboardLocalDatasource.getIncomeExpenseTotals());
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Either<Failure, List<Transaction>> getRecentTransactions({int limit = 5}) {
    try {
      return right(
        _dashboardLocalDatasource.getRecentTransactions(limit: limit),
      );
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }
}
