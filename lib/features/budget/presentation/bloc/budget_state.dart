part of 'budget_bloc.dart';

@immutable
sealed class BudgetState {
  final List<Budget> budgets;

  const BudgetState({this.budgets = const []});
}

final class BudgetInitial extends BudgetState {
  const BudgetInitial({super.budgets = const []});
}

final class BudgetLoading extends BudgetState {
  const BudgetLoading({super.budgets});

  BudgetLoading.fromPrevState(BudgetState state)
    : super(budgets: state.budgets);
}

final class BudgetSuccess extends BudgetState {
  const BudgetSuccess({required super.budgets});
}

final class BudgetFailure extends BudgetState {
  final String message;

  const BudgetFailure({required this.message, super.budgets = const []});

  BudgetFailure.fromPrevState(BudgetState state, {required this.message})
    : super(budgets: state.budgets);
}
