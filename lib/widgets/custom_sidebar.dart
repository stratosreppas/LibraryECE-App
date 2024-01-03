import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFF27506E), // Set the background color to blue
        ),
        child: ListView(
          children: [
            ListTile(
              title: Text('Artemis'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, AppRoutes.artemisPageScreen); // Navigate to the home page
              },            ),
            ListTile(
              title: Text('Κανονισμοί'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, AppRoutes.rulesPageScreen); // Navigate to the home page
              },
            ),
            ListTile(
              title: Text('FAQs'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, AppRoutes.faqsPageScreen); // Navigate to the home page
              },
            ),
            ListTile(
              title: Text('Πληροφορίες'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, AppRoutes.informationPageScreen); // Navigate to the home page
              },
            ),
            ListTile(
              title: Text('Ρυθμίσεις'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, AppRoutes.settingsPageScreen); // Navigate to the home page
              },
            ),
          ],
        ),
      ),
    );
  }
}
