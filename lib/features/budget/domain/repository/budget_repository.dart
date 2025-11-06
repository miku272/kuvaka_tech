import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/model/budget.dart';

abstract interface class BudgetRepository {
  Either<Failure, List<Budget>> getAllBudgets();
  Either<Failure, List<Budget>> getBudgetsForMonth(int month, int year);
  Future<Either<Failure, Budget>> addBudget({
    required String category,
    required double limit,
    required int month,
    required int year,
  });
  Future<Either<Failure, Budget>> updateBudget(Budget budget);
  Future<Either<Failure, void>> deleteBudget(String budgetId);
  Either<Failure, Budget?> getBudgetByCategory(
    String category,
    int month,
    int year,
  );
  Future<Either<Failure, void>> updateBudgetSpent(
    String category,
    int month,
    int year,
  );
}
