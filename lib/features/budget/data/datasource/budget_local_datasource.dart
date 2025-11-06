import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/model/budget.dart';
import '../../../../core/model/transaction.dart';

abstract interface class BudgetLocalDatasource {
  List<Budget> getAllBudgets();
  List<Budget> getBudgetsForMonth(int month, int year);
  Future<Budget> addBudget({
    required String category,
    required double limit,
    required int month,
    required int year,
  });
  Future<Budget> updateBudget(Budget budget);
  Future<void> deleteBudget(String budgetId);
  Budget? getBudgetByCategory(String category, int month, int year);
  Future<void> updateBudgetSpent(String category, int month, int year);
}

class BudgetLocalDatasourceImpl implements BudgetLocalDatasource {
  final Box<Budget> _budgetBox;
  final Box<Transaction> _transactionBox;
  final Uuid _uuid = const Uuid();

  BudgetLocalDatasourceImpl({
    required Box<Budget> budgetBox,
    required Box<Transaction> transactionBox,
  }) : _budgetBox = budgetBox,
       _transactionBox = transactionBox;

  @override
  List<Budget> getAllBudgets() {
    try {
      return _budgetBox.values.toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<Budget> getBudgetsForMonth(int month, int year) {
    try {
      return _budgetBox.values
          .where((budget) => budget.month == month && budget.year == year)
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Budget> addBudget({
    required String category,
    required double limit,
    required int month,
    required int year,
  }) async {
    try {
      // Calculate current spent for this category
      final spent = _calculateSpentForCategory(category, month, year);

      final budget = Budget(
        id: _uuid.v4(),
        category: category,
        limit: limit,
        spent: spent,
        month: month,
        year: year,
      );

      await _budgetBox.add(budget);
      return budget;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Budget> updateBudget(Budget budget) async {
    try {
      final index = _budgetBox.values.toList().indexWhere(
        (b) => b.id == budget.id,
      );

      if (index == -1) {
        throw Exception('Budget not found');
      }

      await _budgetBox.putAt(index, budget);
      return budget;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBudget(String budgetId) async {
    try {
      final index = _budgetBox.values.toList().indexWhere(
        (b) => b.id == budgetId,
      );

      if (index == -1) {
        throw Exception('Budget not found');
      }

      await _budgetBox.deleteAt(index);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Budget? getBudgetByCategory(String category, int month, int year) {
    try {
      return _budgetBox.values.firstWhere(
        (budget) =>
            budget.category == category &&
            budget.month == month &&
            budget.year == year,
        orElse: () => throw Exception('Budget not found'),
      );
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> updateBudgetSpent(String category, int month, int year) async {
    try {
      final budget = getBudgetByCategory(category, month, year);
      if (budget == null) return;

      final spent = _calculateSpentForCategory(category, month, year);

      final updatedBudget = Budget(
        id: budget.id,
        category: budget.category,
        limit: budget.limit,
        spent: spent,
        month: budget.month,
        year: budget.year,
      );

      await updateBudget(updatedBudget);
    } catch (error) {
      rethrow;
    }
  }

  double _calculateSpentForCategory(String category, int month, int year) {
    final transactions = _transactionBox.values.where((transaction) {
      return transaction.category == category &&
          transaction.type == TransactionType.expense &&
          transaction.date.month == month &&
          transaction.date.year == year;
    });

    return transactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );
  }
}
