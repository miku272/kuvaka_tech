import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/transaction.dart';
import '../../../../core/widget/empty_state_widget.dart';
import '../../../../core/widget/error_state_widget.dart';
import '../../../../core/widget/loading_widget.dart';

import '../bloc/transaction_bloc.dart';
import '../widget/add_edit_transaction_sheet.dart';
import '../widget/transaction_filter_chip.dart';
import '../widget/transaction_list_item.dart';

enum TransactionFilter { all, income, expense }

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionFilter _currentFilter = TransactionFilter.all;
  Transaction? _lastDeletedTransaction;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    context.read<TransactionBloc>().add(GetAllTransactionsEvent());
  }

  List<Transaction> _filterTransactions(List<Transaction> transactions) {
    switch (_currentFilter) {
      case TransactionFilter.income:
        return transactions
            .where((t) => t.type == TransactionType.income)
            .toList();
      case TransactionFilter.expense:
        return transactions
            .where((t) => t.type == TransactionType.expense)
            .toList();
      case TransactionFilter.all:
        return transactions;
    }
  }

  void _showAddEditSheet({Transaction? transaction}) async {
    final result = await showModalBottomSheet<Transaction>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditTransactionSheet(transaction: transaction),
    );

    if (result != null && mounted) {
      if (transaction == null) {
        // Add new transaction
        context.read<TransactionBloc>().add(
          AddTransactionEvent(transaction: result),
        );
      } else {
        // Update existing transaction
        context.read<TransactionBloc>().add(
          UpdateTransactionEvent(transaction: result),
        );
      }
    }
  }

  void _deleteTransaction(String transactionId, Transaction transaction) {
    setState(() {
      _lastDeletedTransaction = transaction;
    });

    context.read<TransactionBloc>().add(
      DeleteTransactionEvent(transactionId: transactionId),
    );
  }

  void _undoDelete() {
    if (_lastDeletedTransaction != null) {
      context.read<TransactionBloc>().add(
        AddTransactionEvent(transaction: _lastDeletedTransaction!),
      );
      setState(() {
        _lastDeletedTransaction = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions'), centerTitle: true),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is AddTransactionFailure ||
              state is UpdateTransactionFailure ||
              state is DeleteTransactionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state is AddTransactionFailure
                      ? state.message
                      : state is UpdateTransactionFailure
                      ? state.message
                      : (state as DeleteTransactionFailure).message,
                ),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          } else if (state is AddTransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transaction added successfully')),
            );
          } else if (state is UpdateTransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transaction updated successfully')),
            );
          } else if (state is DeleteTransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Transaction deleted'),
                action: SnackBarAction(label: 'Undo', onPressed: _undoDelete),
              ),
            );
          }
        },
        builder: (context, state) {
          // Show loading on initial load
          if (state is GetAllTransactionsLoading &&
              state.transactions.isEmpty) {
            return const LoadingWidget(message: 'Loading transactions...');
          }

          // Show error state
          if (state is GetAllTransactionsFailure &&
              state.transactions.isEmpty) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: _loadTransactions,
            );
          }

          final allTransactions = state.transactions;
          final filteredTransactions = _filterTransactions(allTransactions)
            ..sort((a, b) => b.date.compareTo(a.date));

          return Column(
            children: [
              // Filter Chips
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TransactionFilterChip(
                        label: 'All',
                        isSelected: _currentFilter == TransactionFilter.all,
                        onTap: () {
                          setState(() {
                            _currentFilter = TransactionFilter.all;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      TransactionFilterChip(
                        label: 'Income',
                        isSelected: _currentFilter == TransactionFilter.income,
                        onTap: () {
                          setState(() {
                            _currentFilter = TransactionFilter.income;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      TransactionFilterChip(
                        label: 'Expense',
                        isSelected: _currentFilter == TransactionFilter.expense,
                        onTap: () {
                          setState(() {
                            _currentFilter = TransactionFilter.expense;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              // Transaction List
              Expanded(
                child: filteredTransactions.isEmpty
                    ? EmptyStateWidget(
                        icon: Icons.receipt_long_outlined,
                        title: 'No Transactions',
                        message: _currentFilter == TransactionFilter.all
                            ? 'Start adding transactions to track your finances'
                            : 'No ${_currentFilter.name} transactions found',
                        action: _currentFilter != TransactionFilter.all
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    _currentFilter = TransactionFilter.all;
                                  });
                                },
                                child: const Text('View All'),
                              )
                            : null,
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          _loadTransactions();
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                          );
                        },
                        child: ListView.builder(
                          itemCount: filteredTransactions.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            return TransactionListItem(
                              transaction: transaction,
                              onEdit: () =>
                                  _showAddEditSheet(transaction: transaction),
                              onDelete: () => _deleteTransaction(
                                transaction.id,
                                transaction,
                              ),
                            );
                          },
                        ),
                      ),
              ),
              // Loading indicator at bottom during operations
              if (state is AddTransactionLoading ||
                  state is UpdateTransactionLoading ||
                  state is DeleteTransactionLoading)
                const LinearProgressIndicator(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditSheet(),
        icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
    );
  }
}
