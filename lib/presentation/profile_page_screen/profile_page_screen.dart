import '../profile_page_screen/widgets/loancomponent_item_widget.dart';
import '../profile_page_screen/widgets/richtooltipgrid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class ProfilePageScreen extends StatelessWidget {
  ProfilePageScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.v),
                child: Column(children: [
                  SizedBox(height: 8.v),
                  _buildRichTooltipGrid(context),
                  SizedBox(height: 16.v),
                  _buildLoanComponentColumn(context)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: SizedBox(
            height: 30.v,
            width: 199.h,
            child: Stack(alignment: Alignment.centerLeft, children: [
              AppbarTitle(
                  text: "ECE Library",
                  margin: EdgeInsets.only(top: 3.v, bottom: 12.v)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 9.h, right: 160.h),
                      decoration: AppDecoration.fillOnPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder15),
                      child: AppbarImage(imagePath: ImageConstant.imgImage1)))
            ])),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMegaphone,
              margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 7.v))
        ],
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildRichTooltipGrid(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 71.v,
                crossAxisCount: 2,
                mainAxisSpacing: 49.h,
                crossAxisSpacing: 49.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return RichtooltipgridItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildLoanComponentColumn(BuildContext context) {
    return Column(children: [
      CustomElevatedButton(
          height: 43.v,
          text: "Ιστορικό Δανεισμών",
          buttonStyle: CustomButtonStyles.fillPrimaryTL10,
          buttonTextStyle: CustomTextStyles.titleSmallOnPrimary_2),
      ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 1.v);
          },
          itemCount: 2,
          itemBuilder: (context, index) {
            return LoancomponentItemWidget(onTapthLoan: () {
              onTapthLoan(context);
            });
          })
    ]);
  }

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapthLoan(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageThreeScreen);
  }
}
