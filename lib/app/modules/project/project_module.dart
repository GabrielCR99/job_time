import 'package:flutter_modular/flutter_modular.dart';

import 'register/project_register_module.dart';

class ProjectModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/register', module: ProjectRegisterModule()),
  ];
}
