import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class FiltersPageScreen extends StatelessWidget {
  FiltersPageScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList2 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList3 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList4 = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 2.v),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Row(children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgClose,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                onTap: () {
                                  onTapImgClose(context);
                                }),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 9.h, top: 2.v, bottom: 2.v),
                                child: Text("Φίλτρα",
                                    style:
                                        CustomTextStyles.titleMediumBlack900))
                          ]))),
                  SizedBox(height: 56.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Κατηγορίες",
                      items: dropdownItemList,
                      onChanged: (value) {}),
                  SizedBox(height: 23.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Συγγραφείς",
                      items: dropdownItemList1,
                      onChanged: (value) {}),
                  SizedBox(height: 23.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Εκδόσεις",
                      items: dropdownItemList2,
                      onChanged: (value) {}),
                  SizedBox(height: 23.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Χρονολογία Έκδοσης",
                      items: dropdownItemList3,
                      onChanged: (value) {}),
                  SizedBox(height: 23.v),
                  CustomDropDown(
                      icon: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 13.v, 10.h, 13.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgArrowdownBlueGray100,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      hintText: "Γλώσσα",
                      items: dropdownItemList4,
                      onChanged: (value) {}),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildFrameThirtyEight(context)));
  }

  /// Section Widget
  Widget _buildFrameThirtyEight(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 66.h, right: 66.h, bottom: 10.v),
        decoration: AppDecoration.fillBlueGray,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    onTapTxtWidget(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(top: 13.v, bottom: 11.v),
                      child: Text("Καθαρισμός",
                          style: CustomTextStyles.labelLargePrimary))),
              CustomElevatedButton(
                  height: 40.v,
                  width: 140.h,
                  text: "Εφαρμογή",
                  margin: EdgeInsets.only(left: 20.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL19,
                  buttonTextStyle: CustomTextStyles.titleSmallOnPrimary_1,
                  onPressed: () {
                    onTaptf(context);
                  })
            ]));
  }

  /// Navigates back to the previous screen.
  onTapImgClose(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTaptf(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
  }
}
