import 'package:flutter/material.dart';
import 'package:stratos_s_application3/widgets/custom_sidebar.dart';
import 'package:stratos_s_application3/widgets/custom_appbar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';



class AppTemplate extends StatelessWidget {

  final Widget body;
  int initialIndex;

  AppTemplate({required this.body, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SideBar(),
      appBar: TopBar(),
      body: body,
      bottomNavigationBar: CustomBottomBar(initialIndex: initialIndex),
    );
  }
}