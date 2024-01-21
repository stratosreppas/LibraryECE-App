import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;

  CustomSearchBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          // Return the color for the default state
          return theme.primaryColor;
        },
      ),
      controller: searchController,
      hintText: " Αναζητήστε εδώ",
      hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) {
          // Return the style for the default state
          return TextStyle(
            color: appTheme.blueGray100,
            fontSize: 15.h,
          ); // Customize with your color
        },
      ),
      trailing: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              String searchText = searchController.text;

              // Navigate when the trailing icon is tapped
              Navigator.pushNamed(context, AppRoutes.resultPageScreen,
                  arguments: {'searchText': searchText});
            },
            child: Icon(
              Icons.search_outlined,
              color: appTheme.blueGray100,
            ),
          ),
        ),
      ],
      onSubmitted: (String string) {
        Navigator.pushNamed(context, AppRoutes.resultPageScreen,
            arguments: {'searchText': string});
      },
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) {
          // Return the style for the default state
          return TextStyle(
              color: appTheme.blueGray100); // Customize with your color
        },
      ),
    );
  }
}
