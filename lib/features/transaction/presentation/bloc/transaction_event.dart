part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  AddTransactionEvent({required this.transaction});
}

final class DeleteTransactionEvent extends TransactionEvent {
  final String transactionId;

  DeleteTransactionEvent({required this.transactionId});
}

final class UpdateTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  UpdateTransactionEvent({required this.transaction});
}

final class GetAllTransactionsEvent extends TransactionEvent {}
