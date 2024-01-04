import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0XFF27506E),
      elevation: 5, // Add elevation for drop shadow
      automaticallyImplyLeading: false, // Remove the back arrow
      title: Row(
        children: [
          // Logo on the left
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/image_not_found.png',
              width: 40, // Adjust the size as needed
              height: 40,
            ),
          ),
          // Title with Lexend font and d9d9d9 color
          Text(
            'ECE Library',
            style: TextStyle(
              fontFamily: 'Lexend', // Use Lexend font
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD9D9D9), // Set the font color to d9d9d9
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(2, 2),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
