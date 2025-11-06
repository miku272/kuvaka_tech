import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/model/transaction.dart';

abstract interface class TransactionRepository {
  Either<Failure, List<Transaction>> getAllTransactions();
  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction);
  Either<Failure, Transaction> editTransaction(Transaction transaction);
  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
