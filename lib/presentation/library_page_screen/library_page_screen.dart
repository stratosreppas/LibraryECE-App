import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
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
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
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
                ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: SizedBox(
            height: 30.v,
            width: 199.h,
            child: Stack(alignment: Alignment.centerLeft, children: [
              AppbarTitle(
                  text: "ECE Library",
                  margin: EdgeInsets.only(top: 3.v, bottom: 12.v)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 9.h, right: 160.h),
                      decoration: AppDecoration.fillOnPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder15),
                      child: AppbarImage(imagePath: ImageConstant.imgImage1)))
            ])),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMegaphone,
              margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 7.v))
        ],
        styleType: Style.bgFill);
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

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Library:
        return "/";
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Profile:
        return AppRoutes.notificationsPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.notificationsPage:
        return NotificationsPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the bookPageFiveScreen when the action is triggered.
  onTapImgImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageFiveScreen);
  }
}
