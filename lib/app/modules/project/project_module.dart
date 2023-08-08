import 'package:flutter_modular/flutter_modular.dart';

import 'detail/project_detail_module.dart';
import 'register/project_register_module.dart';
import 'task/task_module.dart';

final class ProjectModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r
      ..module('/register', module: ProjectRegisterModule())
      ..module('/detail', module: ProjectDetailModule())
      ..module('/task', module: TaskModule());
  }
}
