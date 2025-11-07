import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/model/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpense = transaction.type == TransactionType.expense;
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      resizeDuration: const Duration(milliseconds: 200),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Transaction'),
              content: const Text(
                'Are you sure you want to delete this transaction?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        onDelete();
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isExpense
                        ? const Color(
                            AppColors.errorLight,
                          ).withValues(alpha: 0.1)
                        : const Color(
                            AppColors.secondaryLight,
                          ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(transaction.category),
                    color: isExpense
                        ? const Color(AppColors.errorLight)
                        : const Color(AppColors.secondaryLight),
                  ),
                ),
                const SizedBox(width: 16),
                // Transaction Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.note ?? transaction.category,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            transaction.category,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dateFormat.format(transaction.date),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Amount
                Text(
                  '${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isExpense
                        ? const Color(AppColors.errorLight)
                        : const Color(AppColors.secondaryLight),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'travel':
        return Icons.directions_car;
      case 'bills':
        return Icons.receipt_long;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'health':
        return Icons.local_hospital;
      case 'education':
        return Icons.school;
      case 'salary':
        return Icons.account_balance_wallet;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}
