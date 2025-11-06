import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/model/budget.dart';
import '../../../../core/model/transaction.dart';

abstract interface class DashboardLocalDatasource {
  List<Transaction> getRecentTransactions({int limit});
  Map<String, double> getIncomeExpenseTotals();
  Map<String, double> getExpenseByCategory();
  List<Budget> getBudgets();
}

class DashboardLocalDatasourceImpl implements DashboardLocalDatasource {
  final Box<Transaction> _transactionBox;
  final Box<Budget> _budgetBox;

  DashboardLocalDatasourceImpl({
    required Box<Transaction> transactionBox,
    required Box<Budget> budgetBox,
  }) : _transactionBox = transactionBox,
       _budgetBox = budgetBox;

  @override
  List<Transaction> getRecentTransactions({int limit = 5}) {
    try {
      final txns = _transactionBox.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      return txns.take(limit).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Map<String, double> getIncomeExpenseTotals() {
    try {
      double totalIncome = 0;
      double totalExpense = 0;

      for (final txn in _transactionBox.values) {
        if (txn.type == TransactionType.income) {
          totalIncome += txn.amount;
        } else {
          totalExpense += txn.amount;
        }
      }

      return {'income': totalIncome, 'expense': totalExpense};
    } catch (error) {
      rethrow;
    }
  }

  @override
  Map<String, double> getExpenseByCategory() {
    try {
      final Map<String, double> categoryTotals = {};

      for (final txn in _transactionBox.values) {
        if (txn.type == TransactionType.expense) {
          categoryTotals.update(
            txn.category,
            (value) => value + txn.amount,
            ifAbsent: () => txn.amount,
          );
        }
      }
      return categoryTotals;
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<Budget> getBudgets() {
    try {
      return _budgetBox.values.toList();
    } catch (error) {
      rethrow;
    }
  }
}
