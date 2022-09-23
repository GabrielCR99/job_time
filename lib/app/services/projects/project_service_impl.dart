import 'package:flutter/foundation.dart';

import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../entities/project_task.dart';
import '../../repositories/projects/project_repository.dart';
import '../../view_models/project_model.dart';
import '../../view_models/project_task_model.dart';
import 'project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _repository;

  const ProjectServiceImpl({required ProjectRepository repository})
      : _repository = repository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..name = projectModel.name
      ..estimate = projectModel.estimate
      ..status = projectModel.status;

    await _repository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _repository.findByStatus(status);

    for (final project in projects) {
      await project.tasks.load();
    }

    return projects.map(ProjectModel.fromEntity).toList();
  }

  @override
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;

    final project = await _repository.addTask(projectId, projectTask);

    await _loadTasks(project);

    return ProjectModel.fromEntity(project);
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final project = await _repository.findById(projectId);

    await _loadTasks(project);

    return ProjectModel.fromEntity(project);
  }

  @override
  Future<void> finish(int projectId) => _repository.finish(projectId);

  Future<void> _loadTasks(Project project) async {
    if (!kIsWeb) {
      project.tasks.loadSync();
    } else {
      await project.tasks.load();
    }
  }
}
