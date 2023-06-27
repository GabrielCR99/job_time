import 'package:flutter_modular/flutter_modular.dart';

import 'detail/project_detail_module.dart';
import 'register/project_register_module.dart';
import 'task/task_module.dart';

final class ProjectModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ModuleRoute<void>('/register', module: ProjectRegisterModule()),
    ModuleRoute<void>('/detail', module: ProjectDetailModule()),
    ModuleRoute<void>('/task', module: TaskModule()),
  ];
}
