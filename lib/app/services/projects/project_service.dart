import '../../entities/project_status.dart';
import '../../view_models/project_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
}
