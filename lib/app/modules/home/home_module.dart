import 'package:flutter_modular/flutter_modular.dart';

import 'controller/home_controller.dart';
import 'home_page.dart';

final class HomeModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<HomeController>(
      HomeController.new,
      config: BindConfig(onDispose: (value) => value.close()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => const HomePage());
  }
}
