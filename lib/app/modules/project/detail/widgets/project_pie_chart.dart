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
              title: '$totalTasks h',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              value: residual.toDouble(),
              color: theme.primaryColorLight,
              showTitle: true,
              title: '$residual h',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        : [
            PieChartSectionData(
              value: sanitizedTotalTasks,
              color: Colors.red,
              showTitle: true,
              title: '${totalTasks}h',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ];

    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sections: chartData,
              ),
            ),
            Center(
              child: Text(
                '$projectEstimate h',
                style: TextStyle(
                  fontSize: 25,
                  color: theme.primaryColor,
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
