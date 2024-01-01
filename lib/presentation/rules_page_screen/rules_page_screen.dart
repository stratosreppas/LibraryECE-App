import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';

class RulesPageScreen extends StatelessWidget {
  const RulesPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                      height: 28.v,
                      width: double.maxFinite,
                      decoration: BoxDecoration(color: appTheme.blueGray100)),
                  SizedBox(height: 14.v),
                  _buildDropContent1(context),
                  SizedBox(height: 14.v),
                  _buildDropContent2(context),
                  SizedBox(height: 14.v),
                  _buildDropContent3(context),
                  SizedBox(height: 14.v),
                  _buildDropContent4(context),
                  SizedBox(height: 5.v)
                ]))));
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
            text: "Κανονισμοί", margin: EdgeInsets.only(left: 2.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildDropContent1(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15.v, bottom: 25.v),
                  child: Text("Δανεισμός βιβλίων",
                      style: CustomTextStyles.titleMediumMedium)),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent2(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15.v, bottom: 25.v),
                  child: Text("Ανανεώσεις δανεισμού",
                      style: CustomTextStyles.titleMediumMedium)),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent3(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15.v, bottom: 25.v),
                  child: Text("Αναγνωστήριο",
                      style: CustomTextStyles.titleMediumMedium)),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent4(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15.v, bottom: 25.v),
                  child: Text("Φωτοτυπίες",
                      style: CustomTextStyles.titleMediumMedium)),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
