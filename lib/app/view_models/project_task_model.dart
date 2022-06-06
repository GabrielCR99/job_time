import '../entities/project_task.dart';

class ProjectTaskModel {
  final String name;
  final int? id;
  final int duration;

  const ProjectTaskModel({
    required this.duration,
    required this.name,
    this.id,
  });

  factory ProjectTaskModel.fromEntity(ProjectTask projectTask) {
    return ProjectTaskModel(
      duration: projectTask.duration,
      name: projectTask.name,
    );
  }
}
