import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/model/transaction.dart';

abstract interface class TransactionRemoteDatasource {
  List<Transaction> getAllTransactions();
  Future<Transaction> addTransaction(Transaction transaction);
  Transaction editTransaction(Transaction transaction);
  Future<void> deleteTransaction(String transactionId);
}

class TransactionRemoteDatasourceImpl extends TransactionRemoteDatasource {
  final Box<Transaction> _transactionBox;

  TransactionRemoteDatasourceImpl({required Box<Transaction> transactionBox})
    : _transactionBox = transactionBox;

  @override
  Future<Transaction> addTransaction(Transaction transaction) async {
    try {
      final id = await _transactionBox.add(transaction);
      final addedTransaction = _transactionBox.get(id);

      if (addedTransaction != null) {
        return addedTransaction;
      } else {
        throw Exception('Failed to add transaction');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      final key = _transactionBox.keys.firstWhere(
        (k) => _transactionBox.get(k)?.id == transactionId,
      );
      await _transactionBox.delete(key);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Transaction editTransaction(Transaction transaction) {
    try {
      final key = _transactionBox.keys.firstWhere(
        (k) => _transactionBox.get(k)?.id == transaction.id,
      );
      _transactionBox.put(key, transaction);
      final updatedTransaction = _transactionBox.get(key);

      if (updatedTransaction != null) {
        return updatedTransaction;
      } else {
        throw Exception('Failed to update transaction');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<Transaction> getAllTransactions() {
    try {
      final transactions = _transactionBox.values.toList();
      return transactions;
    } catch (error) {
      rethrow;
    }
  }
}
