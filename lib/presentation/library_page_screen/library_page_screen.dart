import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
import 'package:stratos_s_application3/widgets/custom_sidebar.dart';
import 'package:stratos_s_application3/widgets/custom_appbar.dart';

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
    return SafeArea(
        child: AppTemplate(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 21.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              child: Column(children: [
                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 24.h),
                                    child: CustomSearchView(
                                        controller: searchController,
                                        hintText: "  Αναζητήστε εδώ")),
                                SizedBox(height: 22.v),
                                _buildSearchRow(context),
                                SizedBox(height: 21.v),
                                _buildBookList(context)
                              ]))))
                ]
                )
            ),
          initialIndex: 1,
        )
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
                              width: 24.adaptSize)),
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
                onTapImgImage(context);
              });
            }));
  }

  /// Navigates to the bookPageFiveScreen when the action is triggered.
  onTapImgImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageFiveScreen);
  }
}
