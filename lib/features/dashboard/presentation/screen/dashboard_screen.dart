import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/error_state_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../domain/entity/dashboard_summary.dart';
import '../bloc/dashboard_bloc.dart';
import '../widget/balance_card.dart';
import '../widget/expenses_chart.dart';
import '../widget/recent_transaction_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    context.read<DashboardBloc>().add(LoadDashboardDataEvent());
  }

  Widget _buildPortraitLayout(
    DashboardSummary summary,
    DashboardState state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BalanceCard(dashboardSummary: summary),
        const SizedBox(height: 24),
        Text('Recent Transactions', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        RecentTransactionsList(transactions: summary.recentTransactions),
        const SizedBox(height: 24),
        Text('Expenses by Category', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        ExpensesChart(categoryTotals: summary.categoryTotals),
        if (state is DashboardLoading) ...[
          const SizedBox(height: 16),
          const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLandscapeLayout(
    DashboardSummary summary,
    DashboardState state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BalanceCard(dashboardSummary: summary),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Transactions',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  RecentTransactionsList(
                    transactions: summary.recentTransactions,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expenses by Category',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ExpensesChart(categoryTotals: summary.categoryTotals),
                ],
              ),
            ),
          ],
        ),
        if (state is DashboardLoading) ...[
          const SizedBox(height: 16),
          const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          // Show loading on initial load
          if (state is DashboardLoading && state.dashboardSummary == null) {
            return const LoadingWidget(message: 'Loading dashboard data...');
          }

          // Show error state
          if (state is DashboardFailure && state.dashboardSummary == null) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: _loadDashboardData,
            );
          }

          // Show content with data
          final summary = state.dashboardSummary;
          if (summary == null) {
            return ErrorStateWidget(
              message: 'No data available',
              onRetry: _loadDashboardData,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _loadDashboardData();
              // Wait for the state to change
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape = constraints.maxWidth > 600;

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: isLandscape
                      ? _buildLandscapeLayout(summary, state, theme)
                      : _buildPortraitLayout(summary, state, theme),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
