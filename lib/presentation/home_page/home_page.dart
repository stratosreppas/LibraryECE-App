import '../home_page/widgets/book_item_widget.dart';
import '../home_page/widgets/userprofile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppTemplate(
            body: SingleChildScrollView(
      child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 2.v),
          child: Column(children: [
            SizedBox(height: 7.v),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 7.v),
                decoration: AppDecoration.fillPrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 12.v),
                      _buildProgressBar(context),
                      SizedBox(height: 15.v),
                      _buildCurrentLoans(context)
                    ])),
            SizedBox(height: 5.v),
            _buildFavouriteBooks(context)
          ])),
    )));
  }

  /// Section Widget
  Widget _buildProgressBar(BuildContext context) {
    return SizedBox(
        height: 144.v,
        width: 304.h,
        child: Stack(alignment: Alignment.bottomRight, children: [
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 132.h,
                  margin: EdgeInsets.only(top: 5.v, right: 30.h),
                  child: Text("ΚΩΣΤΑΣ ΠΑΠΑΔΟΠΟΥΛΟΣ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeInterOnPrimary))),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.only(right: 8.h, top: 1.v),
                  padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 6.v),
                  decoration: AppDecoration.fillRed900.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 11.h),
                            child: Text("Ποινή",
                                style:
                                    CustomTextStyles.bodyLargeInterOnPrimary)),
                        SizedBox(height: 11.v),
                        Text("23/10/26",
                            style: CustomTextStyles.bodyLargeInterOnPrimary),
                        SizedBox(height: 10.v)
                      ]))),
          Align(
              alignment: Alignment.topLeft,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    height: 120.adaptSize,
                    width: 120.adaptSize,
                    margin: EdgeInsets.only(bottom: 23.v),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 60.adaptSize,
                              width: 60.adaptSize,
                              decoration: AppDecoration.fillOnPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder30),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgImage1,
                                  height: 60.adaptSize,
                                  width: 60.adaptSize,
                                  radius: BorderRadius.vertical(
                                      bottom: Radius.circular(5.h)),
                                  alignment: Alignment.center))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 80.adaptSize,
                              width: 80.adaptSize,
                              child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: appTheme.gray60001,
                                  color: appTheme.green900,
                                  strokeWidth: 6.h))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 100.adaptSize,
                              width: 100.adaptSize,
                              child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: appTheme.gray500,
                                  color: appTheme.lime800,
                                  strokeWidth: 6.h))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 120.adaptSize,
                              width: 120.adaptSize,
                              child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: appTheme.blueGray100,
                                  color: theme.colorScheme.onPrimaryContainer,
                                  strokeWidth: 6.h)))
                    ])),
                Padding(
                    padding: EdgeInsets.only(left: 8.h, top: 65.v),
                    child: Column(children: [
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillOnPrimaryContainer
                              .copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text("7 days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          )),
                      SizedBox(height: 5.v),
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillLime.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text("7 days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          )),
                      SizedBox(height: 5.v),
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillLightGreen.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text("6 days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          ))
                    ]))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildCurrentLoans(BuildContext context) {
    return Container(
        height: 286.v,
        width: 313.h,
        margin: EdgeInsets.only(left: 3.h),
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text("Τρέχοντες Δανεισμοί",
                      style: CustomTextStyles.titleSmallOnPrimary))),
          Align(
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          onTapTxtWidget(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: Text("Προηγ. δανεισμοί",
                                style: CustomTextStyles.labelMediumRoboto)))),
                SizedBox(height: 7.v),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.v);
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return UserprofileItemWidget(onTapImgImage: () {
                        onTapImgImage(context);
                      });
                    })
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildFavouriteBooks(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 3.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 12.h, right: 21.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: Text("Αγαπημένα Βιβλία",
                                style: CustomTextStyles.titleMediumOnPrimary)),
                        GestureDetector(
                            onTap: () {
                              onTapTxtWidget1(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.v),
                                child: Text("Προβολή όλων",
                                    style: CustomTextStyles.labelMediumRoboto)))
                      ])),
              SizedBox(height: 5.v),
              Container(
                  height: 115.v,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder18),
                  child: ListView.separated(
                      padding: EdgeInsets.only(left: 4.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8.h);
                      },
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return BookItemWidget(onTapImgOperatingSystemImage: () {
                          onTapImgOperatingSystemImage(context);
                        });
                      })),
              SizedBox(height: 1.v)
            ]));
  }

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapImgOperatingSystemImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageThreeScreen);
  }

  /// Navigates to the bookPageFourScreen when the action is triggered.
  onTapImgImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookPageFourScreen);
  }

  /// Navigates to the profilePageScreen when the action is triggered.
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profilePageScreen);
  }

  /// Navigates to the favouritesPageScreen when the action is triggered.
  onTapTxtWidget1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.favouritesPageScreen);
  }
}
