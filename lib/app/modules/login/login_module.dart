import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/login_controller.dart';
import 'login_page.dart';

final class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton((i) => LoginController(authService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute<void>(
      '/',
      child: (context, __) => LoginPage(controller: context.read()),
    ),
  ];
}
