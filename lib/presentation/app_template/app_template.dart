import 'package:flutter/material.dart';
import 'package:stratos_s_application3/widgets/custom_sidebar.dart';
import 'package:stratos_s_application3/widgets/custom_appbar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';

class AppTemplate extends StatelessWidget {
  final Widget body;
  final Widget floatingActionButton;
  int initialIndex;

  AppTemplate({
    required this.body,
    this.floatingActionButton = const SizedBox(width: 0.0, height: 0.0),
    this.initialIndex = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.grey.withOpacity(0.0),
      endDrawer: SideBar(),
      appBar: TopBar(),
      body: body,
      bottomNavigationBar: CustomBottomBar(initialIndex: initialIndex),
      floatingActionButton: floatingActionButton,
    );
  }
}
