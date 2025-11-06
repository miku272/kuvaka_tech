import 'package:flutter/material.dart';

void main() {
  runApp(const KuvakaTech());
}

class KuvakaTech extends StatelessWidget {
  const KuvakaTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuvaka Tech Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(),
    );
  }
}
