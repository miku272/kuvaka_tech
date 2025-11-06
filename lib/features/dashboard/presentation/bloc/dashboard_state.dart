part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {
  final DashboardSummary? dashboardSummary;

  const DashboardState({this.dashboardSummary});
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial({super.dashboardSummary});
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading({super.dashboardSummary});
  DashboardLoading.fromPrevState(DashboardState state)
    : super(dashboardSummary: state.dashboardSummary);
}

final class DashboardSuccess extends DashboardState {
  const DashboardSuccess({required super.dashboardSummary});
}

final class DashboardFailure extends DashboardState {
  final String message;

  const DashboardFailure({required this.message, super.dashboardSummary});

  DashboardFailure.fromPrevState(DashboardState state, {required this.message})
    : super(dashboardSummary: state.dashboardSummary);
}
