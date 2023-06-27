import 'package:flutter/material.dart';

import '../../../../view_models/project_task_model.dart';

class ProjectTaskTile extends StatelessWidget {
  final ProjectTaskModel task;

  const ProjectTaskTile({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task.name),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Duração',
                  style: TextStyle(color: Colors.grey),
                ),
                const WidgetSpan(child: SizedBox(width: 15)),
                TextSpan(
                  text: '${task.duration}h',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
