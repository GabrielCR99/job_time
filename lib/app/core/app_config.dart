import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../firebase_options.dart';

class AppConfig {
  const AppConfig();

  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _setScreenOrientationToPortrait();
    await _firebaseCoreConfig();
  }

  Future<void> _firebaseCoreConfig() async => await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  Future<void> _setScreenOrientationToPortrait() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
}
