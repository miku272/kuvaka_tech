import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/transaction.dart';
import '../../domain/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository,
      super(const TransactionInitial()) {
    on<GetAllTransactionsEvent>(_onGetAllTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }

  void _onGetAllTransactions(
    GetAllTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(GetAllTransactionsLoading.fromPrevState(state));

    final result = _transactionRepository.getAllTransactions();

    result.fold(
      (failure) {
        emit(
          GetAllTransactionsFailure.fromPrevState(
            state,
            message: failure.message,
          ),
        );
      },
      (transactions) {
        emit(GetAllTransactionsSuccess(transactions: transactions));
      },
    );
  }

  void _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(AddTransactionLoading.fromPrevState(state));

    final result = await _transactionRepository.addTransaction(
      event.transaction,
    );

    result.fold(
      (failure) {
        emit(
          AddTransactionFailure.fromPrevState(state, message: failure.message),
        );
      },
      (addedTransaction) {
        final updatedTransactions = [addedTransaction, ...state.transactions];
        emit(AddTransactionSuccess(transactions: updatedTransactions));
      },
    );
  }

  void _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(UpdateTransactionLoading.fromPrevState(state));

    final result = _transactionRepository.editTransaction(event.transaction);

    result.fold(
      (failure) {
        emit(
          UpdateTransactionFailure.fromPrevState(
            state,
            message: failure.message,
          ),
        );
      },
      (updatedTransaction) {
        // Update the transaction in the list
        final updatedTransactions = state.transactions.map((transaction) {
          return transaction.id == updatedTransaction.id
              ? updatedTransaction
              : transaction;
        }).toList();
        emit(UpdateTransactionSuccess(transactions: updatedTransactions));
      },
    );
  }

  void _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(DeleteTransactionLoading.fromPrevState(state));

    final result = await _transactionRepository.deleteTransaction(
      event.transactionId,
    );

    result.fold(
      (failure) {
        emit(
          DeleteTransactionFailure.fromPrevState(
            state,
            message: failure.message,
          ),
        );
      },
      (_) {
        // Remove the transaction from the list
        final updatedTransactions = state.transactions
            .where((transaction) => transaction.id != event.transactionId)
            .toList();
        emit(DeleteTransactionSuccess(transactions: updatedTransactions));
      },
    );
  }
}
