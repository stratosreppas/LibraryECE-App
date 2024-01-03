import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/library_page_screen.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/presentation/profile_page_screen/profile_page_screen.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomePageContainerScreen extends StatelessWidget {
  HomePageContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) =>
                getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Library:
        return AppRoutes.libraryPageScreen;
      case BottomBarEnum.Notifications:
        return AppRoutes.notificationsPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePageScreen;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.libraryPageScreen:
        return LibraryPageScreen();
      case AppRoutes.notificationsPage:
        return NotificationsPage();
      case AppRoutes.profilePageScreen:
        return ProfilePageScreen();
      default:
        return DefaultWidget();
    }
  }
}
