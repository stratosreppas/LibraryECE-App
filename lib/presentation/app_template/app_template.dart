import 'package:flutter/material.dart';
import 'package:stratos_s_application3/widgets/custom_sidebar.dart';
import 'package:stratos_s_application3/widgets/custom_appbar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';



class AppTemplate extends StatelessWidget {

  final Widget body;

  AppTemplate({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SideBar(),
      appBar: TopBar(),
      body: body,
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}