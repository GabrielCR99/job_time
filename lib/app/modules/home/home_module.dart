import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/home_controller.dart';
import 'home_page.dart';

final class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton(
      (i) => HomeController(service: i(), authService: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute<void>('/', child: (_, __) => const HomePage()),
  ];
}
