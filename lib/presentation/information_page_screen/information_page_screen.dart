import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';

class InformationPageScreen extends StatelessWidget {
  const InformationPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(22.h),
                child: Column(children: [
                  _buildContactButton(context),
                  SizedBox(height: 28.v),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.h, vertical: 2.v),
                      decoration: AppDecoration.outlinePrimary.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                height: 37.v,
                                width: 36.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.h, vertical: 6.v),
                                decoration: AppDecoration.fillPrimary1.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder18),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgCall,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                    radius: BorderRadius.circular(10.h),
                                    alignment: Alignment.center)),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 52.h, top: 8.v, bottom: 10.v),
                                child: Text("210 772 1085",
                                    style:
                                        CustomTextStyles.titleMediumBlack900))
                          ])),
                  SizedBox(height: 20.v),
                  _buildLibraryButton(context),
                  SizedBox(height: 20.v),
                  _buildWorkingHoursButton(context),
                  SizedBox(height: 28.v),
                  _buildDailyHoursButton(context),
                  SizedBox(height: 21.v),
                  _buildLocationButton(context),
                  SizedBox(height: 29.v),
                  _buildNewBuildingButton(context),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 26.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 2.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "Πληροφορίες", margin: EdgeInsets.only(left: 9.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildContactButton(BuildContext context) {
    return CustomElevatedButton(text: "Επικοινωνήστε με την Βιβλιοθήκη");
  }

  /// Section Widget
  Widget _buildLibraryButton(BuildContext context) {
    return CustomOutlinedButton(
        height: 48.v,
        text: "library@lib.ece.ntua.gr",
        margin: EdgeInsets.only(left: 26.h, right: 25.h),
        leftIcon: Container(
            margin: EdgeInsets.only(right: 25.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.h)),
            child: CustomImageView(
                imagePath: ImageConstant.imgEmail, height: 28.v, width: 26.h)),
        buttonStyle: CustomButtonStyles.outlinePrimary,
        buttonTextStyle: CustomTextStyles.titleMediumBlack900);
  }

  /// Section Widget
  Widget _buildWorkingHoursButton(BuildContext context) {
    return CustomElevatedButton(text: "Ωράριο Λειτουργίας");
  }

  /// Section Widget
  Widget _buildDailyHoursButton(BuildContext context) {
    return CustomOutlinedButton(
        height: 48.v,
        text: "9:00 - 18:00 Καθημερινά",
        margin: EdgeInsets.only(left: 26.h, right: 25.h),
        leftIcon: Container(
            margin: EdgeInsets.only(right: 25.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.h)),
            child: CustomImageView(
                imagePath: ImageConstant.imgClock, height: 28.v, width: 26.h)),
        buttonStyle: CustomButtonStyles.outlinePrimary,
        buttonTextStyle: CustomTextStyles.titleMediumBlack900);
  }

  /// Section Widget
  Widget _buildLocationButton(BuildContext context) {
    return CustomElevatedButton(text: "Πού θα μας Βρείτε");
  }

  /// Section Widget
  Widget _buildNewBuildingButton(BuildContext context) {
    return CustomOutlinedButton(
        height: 48.v,
        text: "Νέο Κτίριο Ηλεκτρολόγων Αίθουσα B.0.9A ",
        margin: EdgeInsets.only(left: 26.h, right: 25.h),
        leftIcon: Container(
            margin: EdgeInsets.only(right: 11.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.h)),
            child: CustomImageView(
                imagePath: ImageConstant.imgLinkedin,
                height: 25.v,
                width: 26.h)),
        buttonStyle: CustomButtonStyles.outlinePrimary,
        buttonTextStyle: CustomTextStyles.titleMediumBlack900);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}


