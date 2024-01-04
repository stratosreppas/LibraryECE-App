import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBooks,
      activeIcon: ImageConstant.imgBooks,
      title: "Library",
      type: BottomBarEnum.Library,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBell,
      activeIcon: ImageConstant.imgBell,
      title: "Notifications",
      type: BottomBarEnum.Notifications,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMaleUser,
      activeIcon: ImageConstant.imgMaleUser,
      title: "Profile",
      type: BottomBarEnum.Profile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.h),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: SizedBox(
              height: 60.v,
              width: 64.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.v),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 32.v,
                            width: 64.h,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                16.h,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 12.h,
                              top: 5.v,
                              right: 11.h,
                            ),
                            child: Text(
                              bottomMenuList[index].title ?? "",
                              style: theme.textTheme.labelLarge!.copyWith(
                                color: appTheme.black900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 48.v,
                    width: 38.h,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(5.h),
                    ),
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      left: 13.h,
                      right: 13.h,
                      bottom: 12.v,
                    ),
                  ),
                ],
              ),
            ),
            activeIcon: SizedBox(
              height: 59.v,
              width: 64.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.v),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 32.v,
                            width: 64.h,
                            decoration: BoxDecoration(
                              color: appTheme.blueGray100,
                              borderRadius: BorderRadius.circular(
                                16.h,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.h,
                              top: 4.v,
                              right: 14.h,
                            ),
                            child: Text(
                              bottomMenuList[index].title ?? "",
                              style: CustomTextStyles
                                  .labelLargeBluegray100SemiBold
                                  .copyWith(
                                color: appTheme.blueGray100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 48.v,
                    width: 38.h,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(5.h),
                    ),
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      left: 13.h,
                      right: 13.h,
                      bottom: 11.v,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
// Use Navigator to navigate to the corresponding page based on the selected index
          switch (bottomMenuList[index].type) {
            case BottomBarEnum.Home:
              Navigator.pushReplacementNamed(context, AppRoutes.homePage); // Replace with your home page route
              break;
            case BottomBarEnum.Library:
              Navigator.pushReplacementNamed(context, AppRoutes.libraryPageScreen); // Replace with your library page route
              break;
            case BottomBarEnum.Notifications:
              Navigator.pushReplacementNamed(context, AppRoutes.notificationsPage); // Replace with your notifications page route
              break;
            case BottomBarEnum.Profile:
              Navigator.pushReplacementNamed(context, AppRoutes.profilePageScreen); // Replace with your profile page route
              break;
          }
          setState(() {});        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Library,
  Notifications,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
