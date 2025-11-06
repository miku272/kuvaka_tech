part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {
  final List<Transaction> transactions;

  const TransactionState({this.transactions = const []});
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial({super.transactions = const []});
}

final class AddTransactionLoading extends TransactionState {
  const AddTransactionLoading({super.transactions});

  AddTransactionLoading.fromPrevState(TransactionState state)
    : super(transactions: state.transactions);
}

final class AddTransactionSuccess extends TransactionState {
  const AddTransactionSuccess({required super.transactions});
}

final class AddTransactionFailure extends TransactionState {
  final String message;

  const AddTransactionFailure({
    required this.message,
    required super.transactions,
  });

  AddTransactionFailure.fromPrevState(
    TransactionState state, {
    required this.message,
  }) : super(transactions: state.transactions);
}

final class DeleteTransactionLoading extends TransactionState {
  const DeleteTransactionLoading({super.transactions});

  DeleteTransactionLoading.fromPrevState(TransactionState state)
    : super(transactions: state.transactions);
}

final class DeleteTransactionSuccess extends TransactionState {
  const DeleteTransactionSuccess({required super.transactions});
}

final class DeleteTransactionFailure extends TransactionState {
  final String message;

  const DeleteTransactionFailure({
    required this.message,
    required super.transactions,
  });

  DeleteTransactionFailure.fromPrevState(
    TransactionState state, {
    required this.message,
  }) : super(transactions: state.transactions);
}

final class UpdateTransactionLoading extends TransactionState {
  const UpdateTransactionLoading({super.transactions});

  UpdateTransactionLoading.fromPrevState(TransactionState state)
    : super(transactions: state.transactions);
}

final class UpdateTransactionSuccess extends TransactionState {
  const UpdateTransactionSuccess({required super.transactions});
}

final class UpdateTransactionFailure extends TransactionState {
  final String message;

  const UpdateTransactionFailure({
    required this.message,
    required super.transactions,
  });

  UpdateTransactionFailure.fromPrevState(
    TransactionState state, {
    required this.message,
  }) : super(transactions: state.transactions);
}

final class GetAllTransactionsLoading extends TransactionState {
  const GetAllTransactionsLoading({super.transactions});

  GetAllTransactionsLoading.fromPrevState(TransactionState state)
    : super(transactions: state.transactions);
}

final class GetAllTransactionsSuccess extends TransactionState {
  const GetAllTransactionsSuccess({required super.transactions});
}

final class GetAllTransactionsFailure extends TransactionState {
  final String message;

  const GetAllTransactionsFailure({
    required this.message,
    required super.transactions,
  });

  GetAllTransactionsFailure.fromPrevState(
    TransactionState state, {
    required this.message,
  }) : super(transactions: state.transactions);
}
