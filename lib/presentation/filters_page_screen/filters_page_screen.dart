import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/filters_page_screen/widgets/checkbox_dropdown_widget.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class FiltersPageScreen extends StatelessWidget {
  FiltersPageScreen({Key? key}) : super(key: key);

  List<String> categoriesList = ["1ο Εξάμηνο", "2ο Εξάμηνο", "3ο Εξάμηνο"];

  List<String> authorsList = ["Author 1", "Author 2", "Author 3"];

  List<String> publisherList = ["Τζιόλα", "Παπασωτηρίου", "Κλειδαριθμός"];

  List<String> publicationYearList = ["2002", "2016", "20020"];

  List<String> languageList = [
    "Ελληνικά",
    "Αγγλικά",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 2.v),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(children: [
                              GestureDetector(
                                onTap: () {
                                  onTapClose(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 28.adaptSize,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 9.h, top: 2.v, bottom: 2.v),
                                  child: Text("Φίλτρα",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.w500)))
                            ]))),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      header: "Κατηγορίες",
                      contents: categoriesList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      header: "Συγγραφείς",
                      contents: authorsList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      header: "Εκδόσεις",
                      contents: publisherList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      header: "Χρονολογία Έκδοσης",
                      contents: publicationYearList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      header: "Γλώσσα",
                      contents: languageList,
                    )
                  ]),
                )),
            bottomNavigationBar: _buildFrameThirtyEight(context)));
  }

  /// Section Widget
  Widget _buildFrameThirtyEight(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 66.h, right: 66.h, bottom: 10.v),
        decoration: AppDecoration.fillBlueGray,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    onTapTxtWidget(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(top: 13.v, bottom: 11.v),
                      child: Text("Καθαρισμός",
                          style: CustomTextStyles.labelLargePrimary))),
              CustomElevatedButton(
                  height: 40.v,
                  width: 140.h,
                  text: "Εφαρμογή",
                  margin: EdgeInsets.only(left: 20.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL19,
                  buttonTextStyle: CustomTextStyles.titleSmallOnPrimary_1,
                  onPressed: () {
                    onTaptf(context);
                  })
            ]));
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTaptf(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen);
  }
}
