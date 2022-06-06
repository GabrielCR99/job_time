import 'package:flutter_modular/flutter_modular.dart';

import 'core/database/database.dart';
import 'core/database/database_impl.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/project/project_module.dart';
import 'modules/splash/splash_page.dart';
import 'repositories/projects/project_repository.dart';
import 'repositories/projects/project_repository_impl.dart';
import 'services/auth/auth_service_impl.dart';
import 'services/projects/project_service.dart';
import 'services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => AuthServiceImpl()),
    Bind.lazySingleton<Database>((_) => DatabaseImpl()),
    Bind.lazySingleton<ProjectRepository>(
      (i) => ProjectRepositoryImpl(database: i()),
    ),
    Bind.lazySingleton<ProjectService>(
      (i) => ProjectServiceImpl(repository: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const SplashPage()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/project', module: ProjectModule()),
  ];
}
