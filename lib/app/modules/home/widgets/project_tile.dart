import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/job_timer_icons.dart';
import '../../../view_models/project_model.dart';
import '../controller/home_controller.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;

  const ProjectTile({
    required this.projectModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey[300]!, width: 3),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      constraints: const BoxConstraints(maxHeight: 90),
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: _goToProjectDetail,
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            Expanded(child: _ProjectProgress(projectModel: projectModel)),
          ],
        ),
      ),
    );
  }

  Future<void> _goToProjectDetail() async {
    await Modular.to.pushNamed('/project/detail/', arguments: projectModel);
    await Modular.get<HomeController>().updateList();
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angleDoubleRight,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: _projectPercentage,
                backgroundColor: Colors.grey,
                color: _projectPercentage > 1
                    ? Colors.red
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('${projectModel.estimate}h'),
          ),
        ],
      ),
    );
  }

  double get _projectPercentage {
    final totalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);

    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return percent;
  }
}
