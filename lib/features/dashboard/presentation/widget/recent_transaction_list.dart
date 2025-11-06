import 'package:flutter/material.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/model/transaction.dart';
import '../../../../core/widget/empty_state_widget.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const RecentTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: EmptyStateWidget(
            icon: Icons.receipt_long_outlined,
            title: 'No Transactions',
            message: 'Start adding transactions to see them here',
          ),
        ),
      );
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        itemCount: transactions.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final txn = transactions[index];
          final isExpense = txn.type == TransactionType.expense;

          return ListTile(
            title: Text(txn.note ?? 'Transaction'),
            subtitle: Text(txn.category),
            trailing: Text(
              '${isExpense ? '-' : '+'}₹${txn.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: isExpense
                    ? const Color(AppColors.errorLight)
                    : const Color(AppColors.secondaryLight),
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
