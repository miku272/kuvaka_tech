import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/model/budget.dart';
import '../../domain/repository/budget_repository.dart';
import '../datasource/budget_local_datasource.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDatasource _budgetLocalDatasource;

  BudgetRepositoryImpl({required BudgetLocalDatasource budgetLocalDatasource})
    : _budgetLocalDatasource = budgetLocalDatasource;

  @override
  Either<Failure, List<Budget>> getAllBudgets() {
    try {
      final budgets = _budgetLocalDatasource.getAllBudgets();
      return right(budgets);
    } catch (error) {
      return left(Failure(message: 'Failed to fetch budgets'));
    }
  }

  @override
  Either<Failure, List<Budget>> getBudgetsForMonth(int month, int year) {
    try {
      final budgets = _budgetLocalDatasource.getBudgetsForMonth(month, year);
      return right(budgets);
    } catch (error) {
      return left(Failure(message: 'Failed to fetch budgets for this month'));
    }
  }

  @override
  Future<Either<Failure, Budget>> addBudget({
    required String category,
    required double limit,
    required int month,
    required int year,
  }) async {
    try {
      final budget = await _budgetLocalDatasource.addBudget(
        category: category,
        limit: limit,
        month: month,
        year: year,
      );
      return right(budget);
    } catch (error) {
      return left(Failure(message: 'Failed to add budget'));
    }
  }

  @override
  Future<Either<Failure, Budget>> updateBudget(Budget budget) async {
    try {
      final updatedBudget = await _budgetLocalDatasource.updateBudget(budget);
      return right(updatedBudget);
    } catch (error) {
      return left(Failure(message: 'Failed to update budget'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBudget(String budgetId) async {
    try {
      await _budgetLocalDatasource.deleteBudget(budgetId);
      return right(null);
    } catch (error) {
      return left(Failure(message: 'Failed to delete budget'));
    }
  }

  @override
  Either<Failure, Budget?> getBudgetByCategory(
    String category,
    int month,
    int year,
  ) {
    try {
      final budget = _budgetLocalDatasource.getBudgetByCategory(
        category,
        month,
        year,
      );
      return right(budget);
    } catch (error) {
      return left(Failure(message: 'Failed to fetch budget'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBudgetSpent(
    String category,
    int month,
    int year,
  ) async {
    try {
      await _budgetLocalDatasource.updateBudgetSpent(category, month, year);
      return right(null);
    } catch (error) {
      return left(Failure(message: 'Failed to update budget spent'));
    }
  }
}
