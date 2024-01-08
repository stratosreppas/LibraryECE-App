import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';

class LocationPageScreen extends StatelessWidget {
  const LocationPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context),
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    color: appTheme.blueGray100,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgLocationPage),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          SizedBox(height: 36.v),
                          CustomImageView(
                              imagePath: ImageConstant.imgRectangle43,
                              height: 143.v,
                              width: 146.h,
                              margin: EdgeInsets.only(left: 95.h))
                        ])))));
  }

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
            text: "Άρτεμις", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
