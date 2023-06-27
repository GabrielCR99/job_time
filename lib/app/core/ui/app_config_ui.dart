part of '../../app_widget.dart';

sealed class AppConfigUi {
  static final ThemeData theme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      border: OutlineInputBorder(),
    ),
    useMaterial3: true,
    primaryColor: const Color(_primaryColor),
    primaryColorLight: const Color(0xFF219FFF),
    primarySwatch: _primarySwatch,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF075685),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );

  static const _primaryColor = 0xFF0066B0;

  static const _primarySwatch = MaterialColor(_primaryColor, {
    50: Color(0xFF005c9e),
    100: Color(0xFF00528d),
    200: Color(0xFF00477b),
    300: Color(0xFF003d6a),
    400: Color(0xFF003358),
    500: Color(0xFF002946),
    600: Color(0xFF001f35),
    700: Color(0xFF001423),
    800: Color(0xFF000a12),
    900: Color(0xFF000000),
  });

  const AppConfigUi._();
}
