import '../entities/project.dart';
import '../entities/project_status.dart';
import 'project_task_model.dart';

final class ProjectModel {
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;
  final int? id;

  const ProjectModel({
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
    this.id,
  });

  factory ProjectModel.fromEntity(Project project) => ProjectModel(
        name: project.name,
        estimate: project.estimate,
        status: project.status,
        tasks: project.tasks.map(ProjectTaskModel.fromEntity).toList(),
        id: project.id,
      );
}
