import 'package:flutter_modular/flutter_modular.dart';

import 'controller/task_controller.dart';
import 'task_page.dart';

final class TaskModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<TaskController>(
      TaskController.new,
      config: BindConfig(onDispose: (value) => value.close()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => const TaskPage());
  }
}
