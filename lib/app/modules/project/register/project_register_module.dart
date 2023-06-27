import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/project_register_controller.dart';
import 'project_register_page.dart';

final class ProjectRegisterModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton((i) => ProjectRegisterController(service: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute<void>('/', child: (_, __) => const ProjectRegisterPage()),
  ];
}
