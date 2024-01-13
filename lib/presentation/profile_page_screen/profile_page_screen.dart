import '../profile_page_screen/widgets/loancomponent_item_widget.dart';
import '../profile_page_screen/widgets/richtooltipgrid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';

// ignore_for_file: must_be_immutable
class ProfilePageScreen extends StatelessWidget {
  ProfilePageScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the home page
        Navigator.popUntil(context, ModalRoute.withName(AppRoutes.homePage));

        return false;
      }, // Prevent default behavior (popping the current route)
      child: SafeArea(
          child: AppTemplate(
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.v),
            child: Column(children: [
              SizedBox(height: 8.v),
              _buildRichTooltipGrid(context),
              SizedBox(height: 16.v),
              _buildLoanComponentColumn(context)
            ])),
        initialIndex: 3,
      )),
    );
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

  Widget _buildLoanComponentColumn(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomElevatedButton(
            height: 43.v,
            text: "Ιστορικό Δανεισμών",
            buttonStyle: CustomButtonStyles.fillPrimaryTL10,
            buttonTextStyle: CustomTextStyles.titleSmallOnPrimary_2,
          ),
          Container(
            height: 240.v,
            child: ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox.shrink();
              },
              itemCount: 1,
              itemBuilder: (context, index) {
                return LoancomponentItemWidget(onTapthLoan: () {
                  onTapthLoan(context);
                });
              },
            ),
          ),
          Container(
            height: 6.v, // Adjust the height as needed
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
    );
  }

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapthLoan(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageThreeScreen);
  }
}
