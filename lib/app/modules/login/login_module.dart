import 'package:flutter_modular/flutter_modular.dart';

import 'controller/login_controller.dart';
import 'login_page.dart';

final class LoginModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<LoginController>(
      LoginController.new,
      config: BindConfig(onDispose: (value) => value.close()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (context) => LoginPage(controller: context.read()));
  }
}
