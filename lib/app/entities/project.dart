import 'package:isar/isar.dart';

import 'project_status.dart';
import 'project_task.dart';

part 'project.g.dart';

@Collection()
final class Project {
  Id? id;
  late String name;
  late int estimate;
  @Enumerated(EnumType.name)
  late ProjectStatus status;

  final tasks = IsarLinks<ProjectTask>();
}
