import 'package:fpdart/fpdart.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/model/budget.dart';
import '../../../../core/model/transaction.dart';

abstract interface class DashboardRepository {
  Either<Failure, List<Transaction>> getRecentTransactions({int limit});
  Either<Failure, Map<String, double>> getIncomeExpensesTotal();
  Either<Failure, Map<String, double>> getExpensesByCategory();
  Either<Failure, List<Budget>> getBudgets();
}
