import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/empty_state_widget.dart';

class ExpensesChart extends StatelessWidget {
  final Map<String, double> categoryTotals;

  const ExpensesChart({super.key, required this.categoryTotals});

  @override
  Widget build(BuildContext context) {
    if (categoryTotals.isEmpty) {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: EmptyStateWidget(
            icon: Icons.pie_chart_outline,
            title: 'No Expenses',
            message: 'Add expenses to see category breakdown',
          ),
        ),
      );
    }

    final sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        radius: 70,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      );
    }).toList();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: sections,
            ),
          ),
        ),
      ),
    );
  }
}
