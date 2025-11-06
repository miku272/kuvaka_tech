import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ThemeToggleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(turns: animation, child: child);
        },
        child: Icon(
          theme.brightness == Brightness.dark
              ? Icons.dark_mode
              : Icons.light_mode,
          key: ValueKey(theme.brightness),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
