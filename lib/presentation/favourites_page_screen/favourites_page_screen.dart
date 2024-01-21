import '../favourites_page_screen/widgets/one_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_floating_button.dart';
import 'package:stratos_s_application3/widgets/custom_icon_button.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';

class FavouritesPageScreen extends StatelessWidget {
  FavouritesPageScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildOne(context),
                SizedBox(height: 3.v),
                _buildTf(context),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: SizedBox(
        height: 30.v,
        width: 199.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AppbarTitle(
              text: "ECE Library",
              margin: EdgeInsets.only(
                top: 3.v,
                bottom: 12.v,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(
                  left: 9.h,
                  right: 160.h,
                ),
                decoration: AppDecoration.fillOnPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder15,
                ),
                child: AppbarImage(
                  imagePath: ImageConstant.imgImage1,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMegaphone,
          margin: EdgeInsets.symmetric(
            horizontal: 5.h,
            vertical: 7.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 1.v,
        );
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return OneItemWidget();
      },
    );
  }

  /// Section Widget
  Widget _buildAvailableCopies2(BuildContext context) {
    return CustomOutlinedButton(
      height: 27.v,
      width: 166.h,
      text: "Διαθέσιμα Αντίτυπα: 2",
      margin: EdgeInsets.only(left: 3.h),
    );
  }

  /// Section Widget
  Widget _buildTf(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      padding: EdgeInsets.symmetric(vertical: 7.v),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 160.v,
            width: 116.h,
            margin: EdgeInsets.only(left: 14.h),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle2114,
                  height: 160.v,
                  width: 116.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4.v,
                      right: 4.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconButton(
                          height: 25.adaptSize,
                          width: 25.adaptSize,
                          padding: EdgeInsets.all(2.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgLinkedinBlack900,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgFavoriteRed90001,
                          height: 20.v,
                          width: 22.h,
                          margin: EdgeInsets.only(
                            left: 7.h,
                            top: 3.v,
                            bottom: 1.v,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 7.h,
              top: 10.v,
              bottom: 5.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 194.h,
                  child: Text(
                    "ΣΥΓΧΡΟΝΑ ΣΥΣΤΗΜΑΤΑ ΑΥΤΟΜΑΤΟΥ ΕΛΕΓΧΟΥ",
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(
                      height: 1.71,
                    ),
                  ),
                ),
                SizedBox(
                  width: 185.h,
                  child: Text(
                    "BISHOP ROBERT, DORF RICHARD",
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallRobotoOnPrimary.copyWith(
                      height: 2.00,
                    ),
                  ),
                ),
                SizedBox(height: 41.v),
                _buildAvailableCopies2(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 60,
      width: 60,
      backgroundColor: appTheme.deepPurple50014,
      child: CustomImageView(
        imagePath: ImageConstant.imgFilterAlt,
        height: 30.0.v,
        width: 30.0.h,
      ),
    );
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
}
