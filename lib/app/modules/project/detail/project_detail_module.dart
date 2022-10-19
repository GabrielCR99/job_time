import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/project_detail_controller.dart';
import 'project_detail_page.dart';

class ProjectDetailModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton<ProjectDetailController>(
      (i) => ProjectDetailController(service: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => ProjectDetailPage()),
  ];
}
