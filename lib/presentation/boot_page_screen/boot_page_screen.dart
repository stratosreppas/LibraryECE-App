import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stratos_s_application3/constraints.dart';

class BootPageScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<BootPageScreen> {
  @override
  void initState() {
    super.initState();
    makeAsyncApiCall();
  }

  Future<String> checkDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Replace 'your_dependency_key' with the actual key you are checking for.
    String? dependencyValue = prefs.getString('email');
    if (dependencyValue != null && dependencyValue.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.homePage);
    } else {
      Navigator.pushNamed(context, AppRoutes.loginPageScreen);
    }
    return dependencyValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Container(),
      ),
    );
  }

  Future<void> makeAsyncApiCall() async {
    String email = await checkDependencies();
    return http.get(
      Uri.parse('${AppConstants.apiUrl}/recommender/load?' + 'email=$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //
    ).then((response) {
      // Parse the response
      if (response.statusCode == 200) {
        return;
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    }).catchError((e) {
      print('Error: $e');
    });
  }
}
