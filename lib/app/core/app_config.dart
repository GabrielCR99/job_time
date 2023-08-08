import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_strategy/url_strategy.dart';

import '../firebase_options.dart';

final class AppConfig {
  const AppConfig();

  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();

    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    await _firebaseCoreConfig();
  }

  Future<void> _firebaseCoreConfig() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
