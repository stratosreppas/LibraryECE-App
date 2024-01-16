import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/filters_page_screen/widgets/checkbox_dropdown_widget.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

class FiltersPageScreen extends StatefulWidget {
  FiltersPageScreen({Key? key}) : super(key: key);

  @override
  State<FiltersPageScreen> createState() => _FiltersPageScreenState();
}

class _FiltersPageScreenState extends State<FiltersPageScreen> {
  List<String> categoriesList = ["Μαθηματικά", "Φυσική", "Σήματα"];

  List<String> authorsList = ["Author 1", "Author 2", "Author 3"];

  List<String> publisherList = ["Τζιόλα", "Παπασωτηρίου", "Κλειδαριθμός"];

  List<String> publicationYearList = ["2002", "2016", "2020"];

  List<String> languageList = [
    "Ελληνικά",
    "Αγγλικά",
  ];

  String searchText = '';

  String languages = 'NaN';
  String categories = 'NaN';
  String authors = 'NaN';
  String publishers = 'NaN';
  String years = 'NaN';

  final List<GlobalKey<CheckBoxDropDownWidgetState>> checkBoxKeys =
      List.generate(5, (index) => GlobalKey<CheckBoxDropDownWidgetState>());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the 'languages' parameter from the arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args);

    if (args.containsKey('searchText')) {
      // Get the value associated with the 'languages' key
      searchText = args['searchText'];
    }

    // Check if the 'languages' key is present in the arguments
    if (args.containsKey('languages')) {
      // Get the value associated with the 'languages' key
      languages = args['languages'];
    }
  }

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
                      key: checkBoxKeys[0],
                      header: "Κατηγορίες",
                      contents: categoriesList,
                      onSelectedValuesChanged: (selectedValues) {
                        categories = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[1],
                      header: "Συγγραφείς",
                      contents: authorsList,
                      onSelectedValuesChanged: (selectedValues) {
                        authors = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[2],
                      header: "Εκδόσεις",
                      contents: publisherList,
                      onSelectedValuesChanged: (selectedValues) {
                        publishers = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[3],
                      header: "Χρονολογία Έκδοσης",
                      contents: publicationYearList,
                      onSelectedValuesChanged: (selectedValues) {
                        years = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[4],
                      header: "Γλώσσα",
                      contents: languageList,
                      onSelectedValuesChanged: (selectedValues) {
                        languages = selectedValues;
                      },
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
                    onTapf(context, languages, authors, publishers, years,
                        categories);
                  })
            ]));
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }

  /// Clears the selection of checkBoxKeys.
  onTapTxtWidget(BuildContext context) {
    // You can now access checkBoxKeys and their states
    for (var key in checkBoxKeys) {
      key.currentState?.clearSelection();
    }
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTapf(BuildContext context, String languages, String authors,
      String publishers, String years, String categories) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen, arguments: {
      'searchText':
          searchText, // Pass searchText as a parameter to the next screen
      'languages': languages,
      'authors': authors,
      'publishers': publishers,
      'years': years,
      'categories': categories, // Pass books as a parameter to the next screen
    });
  }
}
