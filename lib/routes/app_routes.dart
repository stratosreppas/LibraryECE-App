import 'package:flutter/material.dart';
import 'package:stratos_s_application3/presentation/boot_page_screen/boot_page_screen.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/information_page_screen/information_page_screen.dart';
import 'package:stratos_s_application3/presentation/faqs_page_screen/faqs_page_screen.dart';
import 'package:stratos_s_application3/presentation/artemis_page_screen/artemis_page_screen.dart';
import 'package:stratos_s_application3/presentation/rules_page_screen/rules_page_screen.dart';
import 'package:stratos_s_application3/presentation/settings_page_screen/settings_page_screen.dart';
import 'package:stratos_s_application3/presentation/login_page_screen/login_page_screen.dart';
import 'package:stratos_s_application3/presentation/signup_page_screen/signup_page_screen.dart';
import 'package:stratos_s_application3/presentation/home_page_container_screen/home_page_container_screen.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/library_page_screen.dart';
import 'package:stratos_s_application3/presentation/profile_page_screen/profile_page_screen.dart';
import 'package:stratos_s_application3/presentation/favourites_page_screen/favourites_page_screen.dart';
import 'package:stratos_s_application3/presentation/book_page_four_screen/book_page_four_screen.dart';
import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';
import 'package:stratos_s_application3/presentation/book_page_three_screen/book_page_three_screen.dart';
import 'package:stratos_s_application3/presentation/book_page_five_screen/book_page_five_screen.dart';
import 'package:stratos_s_application3/presentation/location_page_screen/location_page_screen.dart';
import 'package:stratos_s_application3/presentation/result_page_screen/result_page_screen.dart';
import 'package:stratos_s_application3/presentation/filters_page_screen/filters_page_screen.dart';
import 'package:stratos_s_application3/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';

class AppRoutes {
  static const String bootPageScreen = '/boot_page_screen';

  static const String templatePage = '/app_template';

  static const String informationPageScreen = '/information_page_screen';

  static const String faqsPageScreen = '/faqs_page_screen';

  static const String artemisPageScreen = '/artemis_page_screen';

  static const String rulesPageScreen = '/rules_page_screen';

  static const String settingsPageScreen = '/settings_page_screen';

  static const String logoutPageScreen = '/logout_page_screen';

  static const String loginPageScreen = '/login_page_screen';

  static const String signupPageScreen = '/signup_page_screen';

  static const String homePage = '/home_page';

  static const String homePageContainerScreen = '/home_page_container_screen';

  static const String libraryPageScreen = '/library_page_screen';

  static const String notificationsPage = '/notifications_page';

  static const String profilePageScreen = '/profile_page_screen';

  static const String favouritesPageScreen = '/favourites_page_screen';

  static const String bookPageFourScreen = '/book_page_four_screen';

  static const String bookPageOneScreen = '/book_page_one_screen';

  static const String bookPageThreeScreen = '/book_page_three_screen';

  static const String bookPageFiveScreen = '/book_page_five_screen';

  static const String locationPageScreen = '/location_page_screen';

  static const String resultPageScreen = '/result_page_screen';

  static const String filtersPageScreen = '/filters_page_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    bootPageScreen: (context) => BootPageScreen(),
    informationPageScreen: (context) => InformationPageScreen(),
    homePage: (context) => HomePage(),
    notificationsPage: (context) => NotificationsPage(),
    faqsPageScreen: (context) => FaqsPageScreen(),
    artemisPageScreen: (context) => ArtemisPageScreen(),
    rulesPageScreen: (context) => RulesPageScreen(),
    settingsPageScreen: (context) => SettingsPageScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
    signupPageScreen: (context) => SignupPageScreen(),
    homePageContainerScreen: (context) => HomePageContainerScreen(),
    libraryPageScreen: (context) => LibraryPageScreen(),
    profilePageScreen: (context) => ProfilePageScreen(),
    favouritesPageScreen: (context) => FavouritesPageScreen(),
    bookPageFourScreen: (context) => NoiseApp(),
    bookPageOneScreen: (context) => BookPageOneScreen(),
    bookPageThreeScreen: (context) => PhotoPage(),
    bookPageFiveScreen: (context) => BookPageFiveScreen(),
    locationPageScreen: (context) => LocationPageScreen(),
    resultPageScreen: (context) => ResultPageScreen(),
    filtersPageScreen: (context) => FiltersPageScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
