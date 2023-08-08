import 'package:flutter_modular/flutter_modular.dart';

import 'core/database/database.dart';
import 'core/database/database_impl.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/project/project_module.dart';
import 'modules/splash/splash_page.dart';
import 'repositories/projects/project_repository.dart';
import 'repositories/projects/project_repository_impl.dart';
import 'services/auth/auth_service.dart';
import 'services/auth/auth_service_impl.dart';
import 'services/projects/project_service.dart';
import 'services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i
      ..addLazySingleton<Database>(DatabaseImpl.new)
      ..addLazySingleton<AuthService>(AuthServiceImpl.new)
      ..addLazySingleton<ProjectRepository>(ProjectRepositoryImpl.new)
      ..addLazySingleton<ProjectService>(ProjectServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r
      ..child('/', child: (_) => const SplashPage())
      ..module('/login', module: LoginModule())
      ..module('/home', module: HomeModule())
      ..module('/project', module: ProjectModule());
  }
}
