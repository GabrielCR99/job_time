import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  final int projectEstimate;
  final int totalTasks;

  const ProjectPieChart({
    required this.projectEstimate,
    required this.totalTasks,
    super.key,
  });

  double get sanitizedTotalTasks => totalTasks.toDouble();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final chartData = residual > 0
        ? [
            PieChartSectionData(
              value: sanitizedTotalTasks,
              color: theme.primaryColor,
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              title: '$totalTasks h',
            ),
            PieChartSectionData(
              value: residual.toDouble(),
              color: theme.primaryColorLight,
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              title: '$residual h',
            ),
          ]
        : [
            PieChartSectionData(
              value: sanitizedTotalTasks,
              color: Colors.red,
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              title: '${totalTasks}h',
            ),
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            PieChart(PieChartData(sections: chartData)),
            Center(
              child: Text(
                '$projectEstimate h',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int get residual => projectEstimate - totalTasks;
}
