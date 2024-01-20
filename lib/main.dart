import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChannels.textInput.invokeMethod('TextInput.hide');

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'ECE Library',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.appNavigationScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
