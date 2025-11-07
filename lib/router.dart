import 'package:go_router/go_router.dart';

import './shell_scaffold.dart';

import './features/dashboard/presentation/screen/dashboard_screen.dart';
import './features/transaction/presentation/screen/transaction_screen.dart';
import './features/budget/presentation/screen/budget_screen.dart';
import './features/settings/presentation/screen/setting_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ShellScaffold(
            currentIndex: _calculateCurrentIndex(state),
            child: child,
          );
        },
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
          GoRoute(
            path: '/settings',
            builder: (context, state) {
              return const SettingScreen();
            },
          ),
        ],
      ),
    ],
  );

  static int _calculateCurrentIndex(GoRouterState state) {
    switch (state.matchedLocation) {
      case '/':
        return 0;
      case '/transactions':
        return 1;
      case '/budget':
        return 2;
      case '/settings':
        return 3;
      default:
        return 0;
    }
  }
}
