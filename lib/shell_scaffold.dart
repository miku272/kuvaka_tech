import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const ShellScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (dipPop, result) {
        if (!canPop) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      SystemNavigator.pop();
                    },
                    child: const Text('Exit'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/transactions');
                break;
              case 2:
                context.go('/budget');
                break;
              default:
                context.go('/');
            }
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_rounded),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(Icons.savings_rounded),
              label: 'Budget',
            ),
          ],
        ),
      ),
    );
  }
}
