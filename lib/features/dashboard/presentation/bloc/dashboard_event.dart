part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class LoadDashboardDataEvent extends DashboardEvent {
  final int recentTransactionsLimit;

  LoadDashboardDataEvent({this.recentTransactionsLimit = 5});
}
