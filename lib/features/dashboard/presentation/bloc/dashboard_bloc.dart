import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/dashboard_summary.dart';
import '../../domain/repository/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc({required DashboardRepository dashboardRepository})
    : _dashboardRepository = dashboardRepository,
      super(const DashboardInitial()) {
    on<LoadDashboardDataEvent>(_onLoadDashboardData);
  }

  void _onLoadDashboardData(
    LoadDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardLoading.fromPrevState(state));

    // Get recent transactions
    final transactionsRes = _dashboardRepository.getRecentTransactions(
      limit: event.recentTransactionsLimit,
    );

    // Get income and expenses totals
    final totalsRes = _dashboardRepository.getIncomeExpensesTotal();

    // Get expenses by category
    final categoryRes = _dashboardRepository.getExpensesByCategory();

    // Get budgets
    final budgetsRes = _dashboardRepository.getBudgets();

    // Check for any failures
    final transactionsFailure = transactionsRes.fold(
      (failure) => failure,
      (_) => null,
    );
    if (transactionsFailure != null) {
      emit(
        DashboardFailure.fromPrevState(
          state,
          message: transactionsFailure.message,
        ),
      );
      return;
    }

    final totalsFailure = totalsRes.fold((failure) => failure, (_) => null);
    if (totalsFailure != null) {
      emit(
        DashboardFailure.fromPrevState(state, message: totalsFailure.message),
      );
      return;
    }

    final categoryFailure = categoryRes.fold((failure) => failure, (_) => null);
    if (categoryFailure != null) {
      emit(
        DashboardFailure.fromPrevState(state, message: categoryFailure.message),
      );
      return;
    }

    final budgetsFailure = budgetsRes.fold((failure) => failure, (_) => null);
    if (budgetsFailure != null) {
      emit(
        DashboardFailure.fromPrevState(state, message: budgetsFailure.message),
      );
      return;
    }

    // Extract all successful values
    final transactions = transactionsRes.getOrElse((_) => []);
    final totals = totalsRes.getOrElse((_) => {});
    final categoryTotals = categoryRes.getOrElse((_) => {});

    final totalIncome = totals['income'] ?? 0.0;
    final totalExpense = totals['expense'] ?? 0.0;

    // Create the complete dashboard summary
    final dashboardSummary = DashboardSummary(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      recentTransactions: transactions,
      categoryTotals: categoryTotals,
    );

    emit(DashboardSuccess(dashboardSummary: dashboardSummary));
  }
}
