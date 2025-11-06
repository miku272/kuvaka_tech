import 'package:flutter/material.dart';

import '../../../../core/constant/app_color.dart';
import '../../domain/entity/dashboard_summary.dart';

class BalanceCard extends StatelessWidget {
  final DashboardSummary dashboardSummary;

  const BalanceCard({super.key, required this.dashboardSummary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double totalIncome = dashboardSummary.totalIncome;
    final double totalExpense = dashboardSummary.totalExpense;
    final double balance = dashboardSummary.balance;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${balance.toStringAsFixed(2)}',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat(
                  label: 'Income',
                  value: totalIncome,
                  color: const Color(AppColors.secondaryLight),
                ),
                _buildStat(
                  label: 'Expense',
                  value: totalExpense,
                  color: const Color(AppColors.errorLight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color.withValues(alpha: 0.8), fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
