import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0XFF27506E),
      elevation: 5, // Add elevation for drop shadow
      title: Row(
        children: [
          // Logo on the left
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/image_logo.png',
              width: 30, // Adjust the size as needed
              height: 30,
            ),
          ),
          // Title with Lexend font
          Text(
            'ECE Library',
            style: TextStyle(
              fontFamily: 'Lexend', // Use Lexend font
              fontSize: 12,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
