import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'core/ui/app_config_ui.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');

    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      builder: Asuka.builder,
      title: 'Job Timer',
      theme: AppConfigUi.theme,
    );
  }
}
