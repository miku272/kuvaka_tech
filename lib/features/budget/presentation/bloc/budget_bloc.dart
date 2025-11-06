import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/budget.dart';
import '../../domain/repository/budget_repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository _budgetRepository;

  BudgetBloc({required BudgetRepository budgetRepository})
    : _budgetRepository = budgetRepository,
      super(const BudgetInitial()) {
    on<GetAllBudgetsEvent>(_onGetAllBudgets);
    on<GetBudgetsForMonthEvent>(_onGetBudgetsForMonth);
    on<AddBudgetEvent>(_onAddBudget);
    on<UpdateBudgetEvent>(_onUpdateBudget);
    on<DeleteBudgetEvent>(_onDeleteBudget);
  }

  void _onGetAllBudgets(GetAllBudgetsEvent event, Emitter<BudgetState> emit) {
    emit(BudgetLoading.fromPrevState(state));

    final result = _budgetRepository.getAllBudgets();

    result.fold(
      (failure) {
        emit(BudgetFailure.fromPrevState(state, message: failure.message));
      },
      (budgets) {
        emit(BudgetSuccess(budgets: budgets));
      },
    );
  }

  void _onGetBudgetsForMonth(
    GetBudgetsForMonthEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(BudgetLoading.fromPrevState(state));

    final result = _budgetRepository.getBudgetsForMonth(
      event.month,
      event.year,
    );

    result.fold(
      (failure) {
        emit(BudgetFailure.fromPrevState(state, message: failure.message));
      },
      (budgets) {
        emit(BudgetSuccess(budgets: budgets));
      },
    );
  }

  void _onAddBudget(AddBudgetEvent event, Emitter<BudgetState> emit) async {
    emit(BudgetLoading.fromPrevState(state));

    final result = await _budgetRepository.addBudget(
      category: event.category,
      limit: event.limit,
      month: event.month,
      year: event.year,
    );

    result.fold(
      (failure) {
        emit(BudgetFailure.fromPrevState(state, message: failure.message));
      },
      (addedBudget) {
        final updatedBudgets = [addedBudget, ...state.budgets];
        emit(BudgetSuccess(budgets: updatedBudgets));
      },
    );
  }

  void _onUpdateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading.fromPrevState(state));

    final result = await _budgetRepository.updateBudget(event.budget);

    result.fold(
      (failure) {
        emit(BudgetFailure.fromPrevState(state, message: failure.message));
      },
      (updatedBudget) {
        final updatedBudgets = state.budgets.map((budget) {
          return budget.id == updatedBudget.id ? updatedBudget : budget;
        }).toList();
        emit(BudgetSuccess(budgets: updatedBudgets));
      },
    );
  }

  void _onDeleteBudget(
    DeleteBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading.fromPrevState(state));

    final result = await _budgetRepository.deleteBudget(event.budgetId);

    result.fold(
      (failure) {
        emit(BudgetFailure.fromPrevState(state, message: failure.message));
      },
      (_) {
        final updatedBudgets = state.budgets
            .where((budget) => budget.id != event.budgetId)
            .toList();
        emit(BudgetSuccess(budgets: updatedBudgets));
      },
    );
  }
}
