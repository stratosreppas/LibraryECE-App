import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/widgets/app_bar/appbar_subtitle.dart';
import 'package:library_ece/widgets/app_bar/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPageScreen extends StatelessWidget {
  const InformationPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(24.h),
                child: Column(children: [
                  Container(
                    width: 320.h,
                    height: 60.v,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: theme.primaryColor),
                    child: Text(
                      "Επικοινωνήστε με την Βιβλιοθήκη",
                      style: TextStyle(
                          color: appTheme.blueGray100,
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.v),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final Uri url = Uri(scheme: "tel", path: "+302107721085");
                      await launchUrl(url);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      side: BorderSide(color: theme.primaryColor, width: 3.v),
                      fixedSize: Size(250.h, 45.v),
                      backgroundColor: appTheme.blueGray100,
                      alignment: Alignment.center,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Container(
                            width: 34.h,
                            height: 34.v,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius:
                                    BorderRadius.circular(20.adaptSize)),
                            child: Icon(
                              Icons.local_phone_outlined,
                              color: Colors.black,
                              size: 32.adaptSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 64.h),
                          child: Text(
                            "210 772 1085",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.h,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.v),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final Uri emailUri = Uri(
                          scheme: "mailto", path: "library@lib.ece.ntua.gr");
                      launchUrl(emailUri);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      side: BorderSide(color: theme.primaryColor, width: 3.v),
                      fixedSize: Size(250.h, 45.v),
                      backgroundColor: appTheme.blueGray100,
                      alignment: Alignment.center,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Container(
                            width: 34.h,
                            height: 34.v,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius:
                                    BorderRadius.circular(20.adaptSize)),
                            child: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                              size: 32.adaptSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 28.h),
                          child: Text(
                            "library@lib.ece.ntua.gr",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24.v),
                  ),
                  Container(
                    width: 320.h,
                    height: 60.v,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: theme.primaryColor),
                    child: Text(
                      "Ωράριο Λειτουργίας",
                      style: TextStyle(
                          color: appTheme.blueGray100,
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.v),
                  ),
                  Container(
                    width: 250.h,
                    height: 45.v,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      border: Border.all(color: theme.primaryColor, width: 3.v),
                      color: appTheme.blueGray100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Container(
                            width: 34.h,
                            height: 34.v,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(20.adaptSize),
                            ),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Colors.black,
                              size: 32.adaptSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.h),
                          child: Text(
                            "09:00-18:00 Καθημερινά",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24.v),
                  ),
                  Container(
                    width: 320.h,
                    height: 60.v,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: theme.primaryColor),
                    child: Text(
                      "Πού Θα μας Βρείτε",
                      style: TextStyle(
                          color: appTheme.blueGray100,
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.v),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final Uri locationUri = Uri(
                          scheme: "https",
                          path: "://maps.app.goo.gl/SAuySSdGvebLNBHG9");
                      launchUrl(locationUri);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      side: BorderSide(color: theme.primaryColor, width: 3.v),
                      fixedSize: Size(250.h, 60.v),
                      backgroundColor: appTheme.blueGray100,
                      alignment: Alignment.center,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Container(
                            width: 34.h,
                            height: 34.v,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius:
                                    BorderRadius.circular(20.adaptSize)),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 32.adaptSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 2.h),
                          child: Text(
                            "Νέο Κτίριο Ηλεκτρολόγων \n        Αίθουσα Β.0.9Α",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 26.h,
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
            text: "Πληροφορίες", margin: EdgeInsets.only(left: 9.h)),
        styleType: Style.bgFill);
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
