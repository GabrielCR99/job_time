import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/task_controller.dart';
import 'task_page.dart';

class TaskModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton<TaskController>((i) => TaskController(service: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const TaskPage()),
  ];
}
