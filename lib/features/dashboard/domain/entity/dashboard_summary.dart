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

  DashboardSummary copyWith({
    double? totalIncome,
    double? totalExpense,
    List<Transaction>? recentTransactions,
    Map<String, double>? categoryTotals,
  }) {
    return DashboardSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      categoryTotals: categoryTotals ?? this.categoryTotals,
    );
  }
}
