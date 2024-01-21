import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle drawerTextStyle = TextStyle(
      color: Color(0xFFD9D9D9), // Set the text color to d9d9d9
    );

    return SizedBox.expand(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(
              top: 50.h), // Add a margin of 50 pixels from the top
          child: SizedBox(
            height: 260.h, // Set the total height of the drawer to 260 pixels
            child: Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              width: 140.h,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFF27506E), // Set the background color to blue
                ),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Artemis', style: drawerTextStyle),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(
                            context,
                            AppRoutes
                                .artemisPageScreen); // Navigate to the home page
                      },
                    ),
                    ListTile(
                      title: Text('Κανονισμοί', style: drawerTextStyle),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(
                            context,
                            AppRoutes
                                .rulesPageScreen); // Navigate to the home page
                      },
                    ),
                    ListTile(
                      title: Text('FAQs', style: drawerTextStyle),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(
                            context,
                            AppRoutes
                                .faqsPageScreen); // Navigate to the home page
                      },
                    ),
                    ListTile(
                      title: Text('Πληροφορίες', style: drawerTextStyle),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(
                            context,
                            AppRoutes
                                .informationPageScreen); // Navigate to the home page
                      },
                    ),
                    ListTile(
                      title: Text('Ρυθμίσεις', style: drawerTextStyle),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(
                            context,
                            AppRoutes
                                .settingsPageScreen); // Navigate to the home page
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
