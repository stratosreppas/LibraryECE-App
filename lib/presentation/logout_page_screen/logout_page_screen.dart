import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class LogoutPageScreen extends StatelessWidget {
  LogoutPageScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList2 = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 40.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDropDown(
                          icon: Container(
                              margin:
                                  EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                              child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgArrowdownBlueGray100,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          hintText: "Ειδοποιήσεις",
                          items: dropdownItemList,
                          onChanged: (value) {}),
                      SizedBox(height: 20.v),
                      CustomDropDown(
                          icon: Container(
                              margin:
                                  EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                              child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgArrowdownBlueGray100,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          hintText: "Αρχική Σελίδα",
                          items: dropdownItemList1,
                          onChanged: (value) {}),
                      SizedBox(height: 20.v),
                      CustomDropDown(
                          icon: Container(
                              margin:
                                  EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                              child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgArrowdownBlueGray100,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          hintText: "Σελίδα Βιβλιοθήκης",
                          items: dropdownItemList2,
                          onChanged: (value) {}),
                      Spacer(),
                      SizedBox(height: 5.v),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 83.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 6.v),
                          decoration: AppDecoration.fillRed.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                                "Είστε σίγουροι ότι  θέλετε να κάνετε log out?",
                                style: CustomTextStyles.titleSmallOnPrimary_3),
                            SizedBox(height: 41.v),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 25.h, right: 21.h),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            onTapTxtWidget(context);
                                          },
                                          child: Text("Ναι",
                                              style: CustomTextStyles
                                                  .titleSmallOnPrimary_3)),
                                      Text("Όχι",
                                          style: CustomTextStyles
                                              .titleSmallOnPrimary_3)
                                    ])),
                            SizedBox(height: 9.v)
                          ]))
                    ])),
            bottomNavigationBar: _buildLogoutButton(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 30.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 6.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "Ρυθμίσεις", margin: EdgeInsets.only(left: 6.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildLogoutButton(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        width: 121.h,
        text: "Logout",
        margin: EdgeInsets.only(left: 120.h, right: 119.h, bottom: 32.v),
        buttonStyle: CustomButtonStyles.fillRed,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimarySemiBold);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }
}
