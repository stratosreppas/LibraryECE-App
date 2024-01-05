import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';

// ignore_for_file: must_be_immutable
class BookPageOneScreen extends StatelessWidget {
  BookPageOneScreen({Key? key}) : super(key: key);

  TextEditingController authorsController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppTemplate(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
          child: Column(
            children: [
              SizedBox(height: 4.v),
              _buildAvailableCopies(context),
              SizedBox(height: 6.v),
              SizedBox(
                child: Container(
                  height: 11.v,
                  width: 340.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.h)),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    decoration: AppDecoration.fillPrimary,
                    child: Column(
                      children: [
                        SizedBox(height: 13.v),
                        _buildExtendableRich1(context),
                        SizedBox(height: 12.v),
                        _buildExtendableRich2(context),
                        SizedBox(height: 12.v),
                        _buildExtendableRich2(context),
                        SizedBox(height: 12.v),
                        _buildExtendableRich2(context),
                        SizedBox(height: 12.v),
                        _buildExtendableRich2(context),
                        SizedBox(height: 12.v),
                        _buildExtendableRich2(context),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 11.v,
                width: 340.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        initialIndex: 1,
      ),
    );
  }

/// Section Widget
  Widget _buildAvailableCopies(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 14.h, right: 11.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgImage2169x121,
                  height: 169.v,
                  width: 121.h,
                  radius: BorderRadius.circular(10.h)),
              Padding(
                  padding: EdgeInsets.only(left: 6.h, bottom: 7.v),
                  child: Column(children: [
                    CustomOutlinedButton(
                        width: 166.h,
                        text: "Διαθέσιμα Αντίτυπα: 3",
                        margin: EdgeInsets.only(right: 5.h),
                        alignment: Alignment.centerRight),
                    SizedBox(height: 71.v),
                    SizedBox(
                        height: 25.v,
                        width: 186.h,
                        child:
                            Stack(alignment: Alignment.centerRight, children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgRectangle30,
                              height: 25.v,
                              width: 186.h,
                              radius: BorderRadius.circular(12.h),
                              alignment: Alignment.center),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 5.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 6.v, bottom: 4.v),
                                            child: Text(
                                                "Πρόσθεσε στα αγαπημένα",
                                                style: CustomTextStyles
                                                    .bodySmallRobotoOnPrimary11)),
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgFavorite,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize,
                                            margin: EdgeInsets.only(left: 5.h))
                                      ])))
                        ])),
                    SizedBox(height: 14.v),
                    SizedBox(
                        height: 25.v,
                        width: 186.h,
                        child: Stack(alignment: Alignment.center, children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgRectangle30,
                              height: 25.v,
                              width: 186.h,
                              radius: BorderRadius.circular(12.h),
                              alignment: Alignment.center,
                              onTap: () {
                                onTapImgImage(context);
                              }),
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 4.v, bottom: 1.v),
                                        child: Text("Βρες το στη Βιβλιοθήκη",
                                            style: CustomTextStyles
                                                .bodySmallRobotoOnPrimary11)),
                                    CustomImageView(
                                        imagePath: ImageConstant.imgPlace,
                                        height: 19.v,
                                        width: 20.h,
                                        margin: EdgeInsets.only(left: 22.h))
                                  ]))
                        ]))
                  ]))
            ]));
  }

  /// Section Widget
  Widget _buildExtendableRich1(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 14.v),
              Container(
                  margin: EdgeInsets.only(right: 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Τίτλος", style: theme.textTheme.titleSmall),
                        SizedBox(height: 6.v),
                        SizedBox(
                            width: 272.h,
                            child: Text(
                                "ΕΙΣΑΓΩΓΗ ΣΤΑ ΣΥΣΤΗΜΑΤΑ ΗΛΕΚΤΡΙΚΗΣ ΕΝΕΡΓΕΙΑΣ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(height: 1.43)))
                      ]))
            ]));
  }

  /// Common widget
  Widget _buildExtendableRich2(BuildContext context) {
    return Container(
        width: 308.h,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 11.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.v),
              Text("Εκδόσεις", style: theme.textTheme.titleSmall),
              SizedBox(height: 7.v),
              Text("Συμμετρία", style: theme.textTheme.bodyMedium)
            ]));
  }

  /// Navigates to the locationPageScreen when the action is triggered.
  onTapImgImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.locationPageScreen);
  }
}
