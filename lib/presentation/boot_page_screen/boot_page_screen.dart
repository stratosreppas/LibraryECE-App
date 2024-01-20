import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BootPageScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<BootPageScreen> {
  @override
  void initState() {
    super.initState();
    checkDependencies();
  }

  void checkDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Replace 'your_dependency_key' with the actual key you are checking for.
    String? dependencyValue = prefs.getString('email');
    if (dependencyValue != null && dependencyValue.isNotEmpty) {
        Navigator.pushNamed(context, AppRoutes.homePage);
    } else {
      Navigator.pushNamed(context, AppRoutes.loginPageScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Container(
          ),
    ),
    );
  }
}
