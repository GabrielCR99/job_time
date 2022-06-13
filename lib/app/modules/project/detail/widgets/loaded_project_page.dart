import 'package:flutter/material.dart';

import '../../../../core/job_timer_icons.dart';
import '../../../../entities/project_status.dart';
import '../../../../view_models/project_model.dart';
import 'project_detail_appbar.dart';
import 'project_pie_chart.dart';
import 'project_task_tile.dart';

class LoadedProjectPage extends StatelessWidget {
  final ProjectModel projectModel;
  final int totalTasks;
  final VoidCallback onPressed;

  const LoadedProjectPage({
    required this.projectModel,
    required this.totalTasks,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          ProjectDetailAppbar(model: projectModel),
          SliverToBoxAdapter(
            child: ProjectPieChart(
              projectEstimate: projectModel.estimate,
              totalTasks: totalTasks,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ProjectTaskTile(task: projectModel.tasks[index]),
              childCount: projectModel.tasks.length,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Visibility(
                  visible: projectModel.status != ProjectStatus.finished &&
                      projectModel.tasks.isNotEmpty,
                  child: ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(JobTimerIcons.okCircled2),
                    label: const Text('Finalizar Projeto'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
