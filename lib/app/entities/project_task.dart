import 'package:isar/isar.dart';

part 'project_task.g.dart';

@Collection()
final class ProjectTask {
  Id? id;
  late String name;
  late int duration;
  late DateTime created = DateTime.now();
}
