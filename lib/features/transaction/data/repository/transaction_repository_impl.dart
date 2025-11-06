import 'package:fpdart/src/either.dart';

import 'package:kuvaka_tech/core/error/failure.dart';

import 'package:kuvaka_tech/core/model/transaction.dart';

import '../../domain/repository/transaction_repository.dart';
import '../datasource/transaction_local_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDatasource _transactionLocalDatasource;

  TransactionRepositoryImpl({
    required TransactionLocalDatasource transactionLocalDatasource,
  }) : _transactionLocalDatasource = transactionLocalDatasource;

  @override
  Future<Either<Failure, Transaction>> addTransaction(
    Transaction transaction,
  ) async {
    try {
      final addedTransaction = await _transactionLocalDatasource.addTransaction(
        transaction,
      );

      return right(addedTransaction);
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    try {
      final deleteFuture = await _transactionLocalDatasource.deleteTransaction(
        transactionId,
      );

      return right(deleteFuture);
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Either<Failure, Transaction> editTransaction(Transaction transaction) {
    try {
      final updatedTransaction = _transactionLocalDatasource.editTransaction(
        transaction,
      );

      return right(updatedTransaction);
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Either<Failure, List<Transaction>> getAllTransactions() {
    try {
      final transactions = _transactionLocalDatasource.getAllTransactions();

      return right(transactions);
    } catch (error) {
      return left(Failure(message: 'Something went wrong'));
    }
  }
}
