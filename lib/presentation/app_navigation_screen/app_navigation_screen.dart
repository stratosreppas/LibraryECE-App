import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Boot Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bootPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Information Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.informationPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home Page",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.homePage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Template Page",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.templatePage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "FAQs Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.faqsPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Artemis Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.artemisPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Rules Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.rulesPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.settingsPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.loginPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SignUp Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signupPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home Page - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.homePageContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Library Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.libraryPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.profilePageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notificationsPage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Favourites Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.favouritesPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book Page Four",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookPageFourScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book Page One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookPageOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book Page Three",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookPageThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book Page Five",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookPageFiveScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Location Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.locationPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Result Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.resultPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Filters Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.filtersPageScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
