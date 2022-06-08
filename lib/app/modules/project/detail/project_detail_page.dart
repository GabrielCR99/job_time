import 'package:flutter/material.dart';

import '../../../core/job_timer_icons.dart';
import 'widgets/project_detail_appbar.dart';
import 'widgets/project_pie_chart.dart';
import 'widgets/project_task_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProjectDetailAppbar(),
            SliverList(
              delegate: SliverChildListDelegate([
                const ProjectPieChart(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(JobTimerIcons.okCircled2),
                    label: const Text('Finalizar Projeto'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
