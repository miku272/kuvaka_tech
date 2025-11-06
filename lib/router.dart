import 'package:go_router/go_router.dart';

import './features/dashboard/presentation/screen/dashboard_screen.dart';
import './features/transaction/presentation/screen/transaction_screen.dart';
import './features/budget/presentation/screen/budget_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: '/transactions',
        builder: (context, state) {
          return const TransactionScreen();
        },
      ),
      GoRoute(
        path: '/budget',
        builder: (context, state) {
          return const BudgetScreen();
        },
      ),
    ],
  );
}
