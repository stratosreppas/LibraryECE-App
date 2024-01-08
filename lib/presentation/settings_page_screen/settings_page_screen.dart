import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class SettingsPageScreen extends StatelessWidget {
  SettingsPageScreen({Key? key}) : super(key: key);

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
                child: Column(children: [
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Ειδοποιήσεις",
                      items: dropdownItemList,
                      onChanged: (value) {}),
                  SizedBox(height: 20.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Αρχική Σελίδα",
                      items: dropdownItemList1,
                      onChanged: (value) {}),
                  SizedBox(height: 20.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Σελίδα Βιβλιοθήκης",
                      items: dropdownItemList2,
                      onChanged: (value) {}),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildLogout(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 30.h,
        leading: GestureDetector(
          onTap: () {
            onTapArrowLeft(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Icon(
              Icons.arrow_back,
              color: appTheme.blueGray100,
              size: 28.adaptSize,
            ),
          ),
        ),
        title: AppbarSubtitle(
            text: "Ρυθμίσεις", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildLogout(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        width: 121.h,
        text: "Logout",
        margin: EdgeInsets.only(left: 120.h, right: 119.h, bottom: 32.v),
        buttonStyle: CustomButtonStyles.fillRed,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimarySemiBold,
        onPressed: () {
          onTapLogout(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the logoutPageScreen when the action is triggered.
  onTapLogout(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.logoutPageScreen);
  }
}
