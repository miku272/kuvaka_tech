import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/budget.dart';
import '../../../../core/widget/empty_state_widget.dart';
import '../../../../core/widget/error_state_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/theme_toggle_button.dart';
import '../bloc/budget_bloc.dart';
import '../widget/add_edit_budget_sheet.dart';
import '../widget/budget_list_item.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadBudgets();
  }

  void _loadBudgets() {
    context.read<BudgetBloc>().add(
      GetBudgetsForMonthEvent(
        month: _selectedDate.month,
        year: _selectedDate.year,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        actions: [
          ThemeToggleButton(
            onPressed: () {
              // Toggle theme
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Month selector
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                InkWell(
                  onTap: _selectMonth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getMonthYearText(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          // Budget list
          Expanded(
            child: BlocConsumer<BudgetBloc, BudgetState>(
              listener: (context, state) {
                if (state is BudgetFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: theme.colorScheme.error,
                      action: SnackBarAction(
                        label: 'Retry',
                        textColor: theme.colorScheme.onError,
                        onPressed: _loadBudgets,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is BudgetLoading && state.budgets.isEmpty) {
                  return const LoadingWidget(message: 'Loading budgets...');
                }

                if (state is BudgetFailure && state.budgets.isEmpty) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: _loadBudgets,
                  );
                }

                if (state.budgets.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.account_balance_wallet,
                    title: 'No Budgets Yet',
                    message:
                        'Create budgets to track your spending\nfor ${_getMonthYearText()}',
                    action: FilledButton.icon(
                      onPressed: _showAddBudgetSheet,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Budget'),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _loadBudgets(),
                  child: ListView.builder(
                    itemCount: state.budgets.length,
                    itemBuilder: (context, index) {
                      final budget = state.budgets[index];
                      return BudgetListItem(
                        budget: budget,
                        onTap: () => _showEditBudgetSheet(budget),
                        onDelete: () => _deleteBudget(budget.id),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddBudgetSheet,
        icon: const Icon(Icons.add),
        label: const Text('Add Budget'),
      ),
    );
  }

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
    });
    _loadBudgets();
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
    });
    _loadBudgets();
  }

  Future<void> _selectMonth() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5);
    final lastDate = DateTime(now.year + 5, 12);

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _loadBudgets();
    }
  }

  String _getMonthYearText() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[_selectedDate.month - 1]} ${_selectedDate.year}';
  }

  Future<void> _showAddBudgetSheet() async {
    final result = await showModalBottomSheet<Budget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddEditBudgetSheet(),
    );

    if (result != null && mounted) {
      context.read<BudgetBloc>().add(
        AddBudgetEvent(
          category: result.category,
          limit: result.limit,
          month: result.month,
          year: result.year,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Budget added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _showEditBudgetSheet(Budget budget) async {
    final result = await showModalBottomSheet<Budget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditBudgetSheet(budget: budget),
    );

    if (result != null && mounted) {
      context.read<BudgetBloc>().add(UpdateBudgetEvent(budget: result));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Budget updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteBudget(String budgetId) {
    context.read<BudgetBloc>().add(DeleteBudgetEvent(budgetId: budgetId));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Budget deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
  }
}
