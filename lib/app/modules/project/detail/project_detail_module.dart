import 'package:flutter_modular/flutter_modular.dart';

import 'controller/project_detail_controller.dart';
import 'project_detail_page.dart';

class ProjectDetailModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<ProjectDetailController>(
      ProjectDetailController.new,
      config: BindConfig(onDispose: (value) => value.close()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => ProjectDetailPage());
  }
}
