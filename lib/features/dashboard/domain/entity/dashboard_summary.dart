import '../../../../core/model/transaction.dart';

class DashboardSummary {
  final double totalIncome;
  final double totalExpense;

  double get balance => totalIncome - totalExpense;

  final List<Transaction> recentTransactions;
  final Map<String, double> categoryTotals;

  DashboardSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.recentTransactions,
    required this.categoryTotals,
  });
}
