import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  const ProjectPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 50,
                    color: theme.primaryColor,
                    showTitle: true,
                    title: '50 h',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: 150,
                    color: theme.primaryColorLight,
                    showTitle: true,
                    title: '150 h',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                '200 h',
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
}
