import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/widgets/checkbox_with_button_dropdown_widget.dart';
import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/core/utils/navigation_utils.dart';

// ignore_for_file: must_be_immutable
class LibraryPageScreen extends StatelessWidget {
  LibraryPageScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  List<String> semesterDropDown = [
    "1ο Εξάμηνο",
    "2ο Εξάμηνο",
    "3ο Εξάμηνο",
    "4ο Εξάμηνο",
    "5ο Εξάμηνο",
    "6ο Εξάμηνο",
    "7ο Εξάμηνο",
    "8ο Εξάμηνο",
    "9ο Εξάμηνο",

  ];

  List<String> categoriesDropDown = [
    "Item One",
    "Item Two",
    "Item Three",
    "Item Four",
    "Item Five",
    "Item Six",
    "Item Seven",
    "Item Eight",
    "Item Nine",
    "Item Ten",
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the home page
        Navigator.popUntil(context, ModalRoute.withName(AppRoutes.homePage));
        return false;
      },
      child: SafeArea(
        child: AppTemplate(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 21.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      child: SearchBar(
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
                                // Navigate when the trailing icon is tapped
                                Navigator.pushNamed(
                                    context, AppRoutes.resultPageScreen);
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
                      )),
                  SizedBox(height: 100.v),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.h, right: 8.h),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: _buildBookList(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.v,
                  )
                ],
              ),
              Positioned(
                top: 85.v,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 180.h),
                  child: CheckBoxButtonDropDownWidget(
                    header: "Εξάμηνο",
                    contents: semesterDropDown,
                  ),
                ),
              ),
              Positioned(
                top: 85.v,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 180.h),
                  child: CheckBoxButtonDropDownWidget(
                    header: "Κατηγορίες",
                    contents: categoriesDropDown,
                  ),
                ),
              ),
            ],
          ),
          initialIndex: 1,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBookList(BuildContext context) {
    return Container(
        decoration: AppDecoration.fillBlueGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 26.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return BooklistItemWidget(onTapImgImage: () {
                slideLeftTo(context, BookPageOneScreen());
              });
            }));
  }

  /// Navigates to the bookPageFiveScreen when the action is triggered.
  goTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return destination; // Replace with the actual screen you want to navigate to
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
