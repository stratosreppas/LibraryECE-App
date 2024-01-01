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

class BookPageFourScreen extends StatelessWidget {
  BookPageFourScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController subtitleTextFieldController = TextEditingController();

  TextEditingController authorsTextFieldController = TextEditingController();

  TextEditingController publisherTextFieldController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 7.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Column(
                      children: [
                        _buildNinetySix(context),
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
                        SizedBox(
                          height: 703.v,
                          width: 340.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 481.v,
                                  width: 340.h,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildExtendableRichColumn(context),
                                      SizedBox(height: 11.v),
                                      _buildSubtitleTextField(context),
                                      SizedBox(height: 11.v),
                                      _buildAuthorsTextField(context),
                                      SizedBox(height: 11.v),
                                      _buildPublisherTextField(context),
                                      SizedBox(height: 11.v),
                                      _buildExtendableRichColumn(context),
                                      SizedBox(height: 11.v),
                                      _buildExtendableRichColumn(context),
                                      SizedBox(height: 11.v),
                                      _buildExtendableRichColumn(context),
                                      SizedBox(height: 11.v),
                                      _buildExtendableRichColumn(context),
                                      SizedBox(height: 11.v),
                                      _buildExtendableRichColumn(context),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 11.v,
                                  width: 340.h,
                                  margin: EdgeInsets.only(bottom: 211.v),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
  Widget _buildAvailableCopiesButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 166.h,
      text: "Διαθέσιμα Αντίτυπα: 5",
    );
  }

  /// Section Widget
  Widget _buildNinetySix(BuildContext context) {
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
            imagePath: ImageConstant.imgImage2,
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
                _buildAvailableCopiesButton(context),
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
  Widget _buildSubtitleTextField(BuildContext context) {
    return CustomFloatingTextField(
      controller: subtitleTextFieldController,
      labelText: "Υπότιτλος",
      labelStyle: theme.textTheme.titleSmall!,
      hintText: "Υπότιτλος",
      hintStyle: theme.textTheme.titleSmall!,
      contentPadding: EdgeInsets.fromLTRB(16.h, 14.v, 16.h, 35.v),
    );
  }

  /// Section Widget
  Widget _buildAuthorsTextField(BuildContext context) {
    return CustomFloatingTextField(
      controller: authorsTextFieldController,
      labelText: "Συγγραφείς",
      labelStyle: theme.textTheme.bodyMedium!,
      hintText: "Συγγραφείς",
    );
  }

  /// Section Widget
  Widget _buildPublisherTextField(BuildContext context) {
    return CustomFloatingTextField(
      controller: publisherTextFieldController,
      labelText: "Εκδόσεις",
      labelStyle: theme.textTheme.bodyMedium!,
      hintText: "Εκδόσεις",
      textInputAction: TextInputAction.done,
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
  Widget _buildExtendableRichColumn(BuildContext context) {
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
          SizedBox(height: 3.v),
          Text(
            "Αριθμός Έκδοσης",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 7.v),
          Text(
            "2η",
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
