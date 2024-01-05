import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';

import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
import 'package:stratos_s_application3/core/utils/navigation_utils.dart';

import 'package:stratos_s_application3/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class LibraryPageScreen extends StatelessWidget {
  LibraryPageScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
          onWillPop: () async {
            // Pop all routes until reaching the home page
            Navigator.popUntil(context, ModalRoute.withName(AppRoutes.homePage));

            return false;
            }, // Prevent default behavior (popping the current route)
        child: SafeArea(
        child: AppTemplate(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 21.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.h),
                          child: CustomSearchView(
                            controller: searchController,
                            hintText: "  Αναζητήστε εδώ",
                          ),
                        ),
                        SizedBox(height: 22.v),
                        _buildSearchRow(context),
                        SizedBox(height: 21.v),
                        _buildBookList(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          initialIndex: 1,
        ),
            ),
      );
  }

  /// Section Widget
  Widget _buildSearchRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 9.h, right: 5.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 7.h, bottom: 1.v),
                  child: CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 7.v, 10.h, 7.v),
                          child: CustomImageView(
                              imagePath:
                              ImageConstant.imgArrowdownBlueGray10024x24,
                              height: 24.adaptSize,
                              width: 12.adaptSize)),
                      hintText: "Εξάμηνα",
                      hintStyle: theme.textTheme.bodyLarge!,
                      items: dropdownItemList,
                      contentPadding:
                      EdgeInsets.only(left: 30.h, top: 9.v, bottom: 9.v),
                      borderDecoration: DropDownStyleHelper.outlineBlack,
                      onChanged: (value) {}))),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(18.h, 7.v, 10.h, 7.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdown,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Κατηγορίες",
                      hintStyle: theme.textTheme.bodyLarge!,
                      items: dropdownItemList1,
                      contentPadding:
                      EdgeInsets.only(left: 19.h, top: 9.v, bottom: 9.v),
                      borderDecoration: DropDownStyleHelper.outlineBlack,
                      onChanged: (value) {})))
        ]));
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
              return SizedBox(height: 40.v);
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

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
