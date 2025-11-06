import 'package:hive_flutter/hive_flutter.dart';

import '../model/transaction.dart';
import '../model/budget.dart';

class HiveService {
  final Box<Transaction> _transactionsBox;
  final Box<Budget> _budgetsBox;

  HiveService({
    required Box<Transaction> transactionsBox,
    required Box<Budget> budgetsBox,
  }) : _transactionsBox = transactionsBox,
       _budgetsBox = budgetsBox;

  List<Transaction> getTransactions() {
    return _transactionsBox.values.toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _transactionsBox.put(transaction.id, transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionsBox.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _transactionsBox.delete(id);
  }

  Transaction? getTransactionById(String id) {
    return _transactionsBox.get(id);
  }

  List<Budget> getBudgets() {
    return _budgetsBox.values.toList();
  }

  Future<void> addBudget(Budget budget) async {
    await _budgetsBox.put(budget.id, budget);
  }

  Future<void> updateBudget(Budget budget) async {
    await _budgetsBox.put(budget.id, budget);
  }

  Future<void> deleteBudget(String id) async {
    await _budgetsBox.delete(id);
  }

  Budget? getBudgetById(String id) {
    return _budgetsBox.get(id);
  }

  Future<void> clearTransactions() async {
    await _transactionsBox.clear();
  }

  Future<void> clearBudgets() async {
    await _budgetsBox.clear();
  }

  Future<void> clearAll() async {
    await _transactionsBox.clear();
    await _budgetsBox.clear();
  }

  Future<void> close() async {
    await _transactionsBox.close();
    await _budgetsBox.close();
  }
}
