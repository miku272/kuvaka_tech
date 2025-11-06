import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './depedencies.dart';

import './core/theme/light_theme.dart';
import './core/theme/dark_theme.dart';

Future<void> main() async {
  await initDependencies();

  runApp(MultiBlocProvider(providers: [], child: const KuvakaTech()));
}

class KuvakaTech extends StatelessWidget {
  const KuvakaTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuvaka Tech Assignment',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      home: const Scaffold(),
    );
  }
}
