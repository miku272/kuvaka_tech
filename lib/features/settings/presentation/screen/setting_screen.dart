import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/app_theme/app_theme_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.settings,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'App Settings',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Customize your app experience',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Theme Section
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'APPEARANCE',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, state) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildThemeTile(
                      context: context,
                      title: 'Light Mode',
                      subtitle: 'Use light theme',
                      icon: Icons.light_mode,
                      iconColor: Colors.amber,
                      isSelected: state.themeMode == ThemeMode.light,
                      onTap: () {
                        context.read<AppThemeCubit>().updateThemeMode(
                          ThemeMode.light,
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 72,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    _buildThemeTile(
                      context: context,
                      title: 'Dark Mode',
                      subtitle: 'Use dark theme',
                      icon: Icons.dark_mode,
                      iconColor: Colors.indigo,
                      isSelected: state.themeMode == ThemeMode.dark,
                      onTap: () {
                        context.read<AppThemeCubit>().updateThemeMode(
                          ThemeMode.dark,
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 72,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    _buildThemeTile(
                      context: context,
                      title: 'System Default',
                      subtitle: 'Follow system theme settings',
                      icon: Icons.brightness_auto,
                      iconColor: Colors.purple,
                      isSelected: state.themeMode == ThemeMode.system,
                      onTap: () {
                        context.read<AppThemeCubit>().updateThemeMode(
                          ThemeMode.system,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          // About Section
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'ABOUT',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  title: const Text('App Version'),
                  subtitle: const Text('1.0.0'),
                ),
                Divider(
                  height: 1,
                  indent: 72,
                  color: theme.colorScheme.outlineVariant,
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.code, color: theme.colorScheme.secondary),
                  ),
                  title: const Text('Developer'),
                  subtitle: const Text('Naresh Sharma'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Footer
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 32,
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'Expense Tracker',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Track your expenses efficiently',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
          : Icon(
              Icons.circle_outlined,
              color: theme.colorScheme.outlineVariant,
            ),
    );
  }
}
