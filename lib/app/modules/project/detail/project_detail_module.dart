import 'package:flutter_modular/flutter_modular.dart';

import 'project_detail_page.dart';

class ProjectDetailModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ProjectDetailPage(),
    ),
  ];
}
