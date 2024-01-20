import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/widgets/checkbox_with_button_dropdown_widget.dart';
import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/core/utils/navigation_utils.dart';
import 'package:stratos_s_application3/widgets/custom_search_bar.dart';

// ignore_for_file: must_be_immutable
class LibraryPageScreen extends StatelessWidget {
  LibraryPageScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();


  List<String> semesterDropDown = [
    "1ο Εξάμηνο",
    "2ο Εξάμηνο",
    "3ο Εξάμηνο",
    "4ο Εξάμηνο",
    "5ο Εξάμηνο",
    "6ο Εξάμηνο",
    "7ο Εξάμηνο",
    "8ο Εξάμηνο",
    "9ο Εξάμηνο",
    "Εκτός Εξαμήνων"

  ];

  List<String> categoriesDropDown = [
    "Ροή Υ",
    "Ροή Λ",
    "Ροή Δ",
    "Ροή Ε",
    "Ροή Ζ",
    "Ροή Η",
    "Ροή Ο",
    "Ροή Ι",
    "Ροή Σ",
    "Ροή Τ",
    "Ροή Φ",
    "Ροή Μ",
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the home page
        Navigator.popUntil(context, ModalRoute.withName(AppRoutes.homePage));
        return false;
      },
      child: SafeArea(
        child: AppTemplate(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 21.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      child: CustomSearchBar(
                        searchController: TextEditingController(),
                      )),
                  SizedBox(height: 100.v),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.h, right: 8.h),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: _buildBookList(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.v,
                  )
                ],
              ),
              Positioned(
                top: 85.v,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 180.h),
                  child: CheckBoxButtonDropDownWidget(
                    header: "Εξάμηνο",
                    contents: semesterDropDown,
                  ),
                ),
              ),
              Positioned(
                top: 85.v,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 180.h),
                  child: CheckBoxButtonDropDownWidget(
                    header: "Κατηγορίες",
                    contents: categoriesDropDown,
                  ),
                ),
              ),
            ],
          ),
          initialIndex: 1,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBookList(BuildContext context) {
    return Container(
        decoration: AppDecoration.fillBlueGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 26.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return BooklistItemWidget(onTapImgImage: () {
                slideLeftTo(context, BookPageOneScreen());
              });
            }));
  }
}