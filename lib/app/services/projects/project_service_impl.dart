import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../repositories/projects/project_repository.dart';
import '../../view_models/project_model.dart';
import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _repository;

  const ProjectServiceImpl({required ProjectRepository repository})
      : _repository = repository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..estimate = projectModel.estimate
      ..status = projectModel.status;

    await _repository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _repository.findByStatus(status);

    return projects.map(ProjectModel.fromEntity).toList();
  }
}
