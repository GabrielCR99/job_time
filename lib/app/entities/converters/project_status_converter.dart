import 'package:isar/isar.dart';

import '../project_status.dart';

class ProjectStatusConverter extends TypeConverter<ProjectStatus, int> {
  const ProjectStatusConverter();

  @override
  ProjectStatus fromIsar(int object) => ProjectStatus.values[object];

  @override
  int toIsar(ProjectStatus object) => object.index;
}
