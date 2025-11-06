part of 'budget_bloc.dart';

@immutable
sealed class BudgetEvent {}

final class GetAllBudgetsEvent extends BudgetEvent {}

final class GetBudgetsForMonthEvent extends BudgetEvent {
  final int month;
  final int year;

  GetBudgetsForMonthEvent({required this.month, required this.year});
}

final class AddBudgetEvent extends BudgetEvent {
  final String category;
  final double limit;
  final int month;
  final int year;

  AddBudgetEvent({
    required this.category,
    required this.limit,
    required this.month,
    required this.year,
  });
}

final class UpdateBudgetEvent extends BudgetEvent {
  final Budget budget;

  UpdateBudgetEvent({required this.budget});
}

final class DeleteBudgetEvent extends BudgetEvent {
  final String budgetId;

  DeleteBudgetEvent({required this.budgetId});
}
