import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_floating_text_field.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';

class BookPageFiveScreen extends StatelessWidget {
  BookPageFiveScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController titleController = TextEditingController();

  TextEditingController subtitleController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 5.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 2.v),
              _buildAvailableCopies(context),
              SizedBox(height: 6.v),
              Container(
                height: 11.v,
                width: 340.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.h),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  decoration: AppDecoration.fillPrimary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 10.v),
                      CustomFloatingTextField(
                        controller: titleController,
                        labelText: "Τίτλος",
                        labelStyle: theme.textTheme.bodyMedium!,
                        hintText: "Τίτλος",
                      ),
                      SizedBox(height: 11.v),
                      CustomFloatingTextField(
                        controller: subtitleController,
                        labelText: "Υπότιτλος",
                        labelStyle: theme.textTheme.titleSmall!,
                        hintText: "Υπότιτλος",
                        hintStyle: theme.textTheme.titleSmall!,
                        textInputAction: TextInputAction.done,
                        contentPadding:
                            EdgeInsets.fromLTRB(16.h, 14.v, 16.h, 35.v),
                      ),
                      SizedBox(height: 11.v),
                      _buildExtendableRich(context),
                      SizedBox(height: 11.v),
                      _buildExtendableRich(context),
                      SizedBox(height: 11.v),
                      _buildExtendableRich(context),
                      SizedBox(height: 11.v),
                      _buildExtendableRich(context),
                      SizedBox(height: 11.v),
                      _buildExtendableRich(context),
                      Spacer(),
                      SizedBox(height: 75.v),
                      _buildExtendableRich(context),
                      _buildExtendableRich(context),
                    ],
                  ),
                ),
              ),
              Container(
                height: 11.v,
                width: 340.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
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
  Widget _buildAvailableCopies(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.h,
        right: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage22,
            height: 169.v,
            width: 121.h,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              bottom: 7.v,
            ),
            child: Column(
              children: [
                CustomOutlinedButton(
                  width: 166.h,
                  text: "Διαθέσιμα Αντίτυπα: 2",
                ),
                SizedBox(height: 71.v),
                SizedBox(
                  height: 25.v,
                  width: 186.h,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle30,
                        height: 25.v,
                        width: 186.h,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 6.v,
                                  bottom: 4.v,
                                ),
                                child: Text(
                                  "Πρόσθεσε στα αγαπημένα",
                                  style: CustomTextStyles
                                      .bodySmallRobotoOnPrimary11,
                                ),
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgFavorite,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                margin: EdgeInsets.only(left: 5.h),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.v),
                SizedBox(
                  height: 25.v,
                  width: 186.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle30,
                        height: 25.v,
                        width: 186.h,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 4.v,
                                bottom: 1.v,
                              ),
                              child: Text(
                                "Βρες το στη Βιβλιοθήκη",
                                style:
                                    CustomTextStyles.bodySmallRobotoOnPrimary11,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgPlace,
                              height: 19.v,
                              width: 20.h,
                              margin: EdgeInsets.only(left: 22.h),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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

  /// Common widget
  Widget _buildExtendableRich(BuildContext context) {
    return Container(
      width: 308.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Text(
            "Εκδόσεις",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 7.v),
          Text(
            "Kλειδάριθμος",
            style: theme.textTheme.bodyMedium,
          ),
        ],
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
