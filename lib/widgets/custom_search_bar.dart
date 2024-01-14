import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/widgets/checkbox_with_button_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/core/utils/navigation_utils.dart';

class CustomSearchBar extends StatelessWidget {


  final TextEditingController searchController;

  CustomSearchBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor:
      MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // Return the color for the default state
          return theme.primaryColor;
        },
      ),
      controller: searchController,
      hintText: " Αναζητήστε εδώ",
      hintStyle:
      MaterialStateProperty.resolveWith<TextStyle?>(
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
              Navigator.pushNamed(
                  context, AppRoutes.resultPageScreen, arguments: {'searchText': searchText});
            },
            child: Icon(
              Icons.search_outlined,
              color: appTheme.blueGray100,
            ),
          ),
        ),
      ],
      onSubmitted: (String string) {
        Navigator.pushNamed(
            context, AppRoutes.resultPageScreen);
      },
      textStyle:
      MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
          // Return the style for the default state
          return TextStyle(
              color: appTheme
                  .blueGray100); // Customize with your color
        },
      ),
    );
  }
}