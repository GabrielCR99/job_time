import 'package:flutter_modular/flutter_modular.dart';

import 'controller/project_register_controller.dart';
import 'project_register_page.dart';

final class ProjectRegisterModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<ProjectRegisterController>(
      ProjectRegisterController.new,
      config: BindConfig(onDispose: (value) => value.close()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => const ProjectRegisterPage());
  }
}
