import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/filters_page_screen/widgets/checkbox_dropdown_widget.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';
import 'package:stratos_s_application3/routes/classes/Filter.dart';

class FiltersPageScreen extends StatefulWidget {
  FiltersPageScreen({Key? key}) : super(key: key);

  @override
  State<FiltersPageScreen> createState() => _FiltersPageScreenState();
}

class _FiltersPageScreenState extends State<FiltersPageScreen> {
  Filter filters = Filter(
    category: [],
    language: [],
    publisher: [],
    author: [],
    year: [],
  );

  String searchText = 'NaN';

  String languages = 'NaN';
  String categories = 'NaN';
  String authors = 'NaN';
  String publishers = 'NaN';
  String years = 'NaN';

  String semesters = 'NaN';
  String interests = 'NaN';

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

    if (args.containsKey('categories')) {
      // Get the value associated with the 'languages' key
      categories = args['categories'];
    }

    if (args.containsKey('authors')) {
      // Get the value associated with the 'languages' key
      authors = args['authors'];
    }

    if (args.containsKey('publishers')) {
      // Get the value associated with the 'languages' key
      publishers = args['publishers'];
    }

    if (args.containsKey('years')) {
      // Get the value associated with the 'languages' key
      years = args['years'];
    }

    if (args.containsKey('filters')) {
      filters = args['filters'];
    }

    if (args.containsKey('semesters')) {
      semesters = args['semesters'];
    }

    if (args.containsKey('interests')) {
      interests = args['interests'];
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
                      contents: filters.category,
                      initialSelectedValues: listify(categories),
                      onSelectedValuesChanged: (selectedValues) {
                        categories = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[1],
                      header: "Συγγραφείς",
                      contents: filters.author,
                      initialSelectedValues: listify(authors),
                      onSelectedValuesChanged: (selectedValues) {
                        authors = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[2],
                      header: "Εκδόσεις",
                      contents: filters.publisher,
                      initialSelectedValues: listify(publishers),
                      onSelectedValuesChanged: (selectedValues) {
                        publishers = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[3],
                      header: "Χρονολογία Έκδοσης",
                      contents: filters.year,
                      initialSelectedValues: listify(years),
                      onSelectedValuesChanged: (selectedValues) {
                        years = selectedValues;
                      },
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[4],
                      header: "Γλώσσα",
                      contents: filters.language,
                      initialSelectedValues: listify(languages),
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
    languages = 'NaN';
    categories = 'NaN';
    authors = 'NaN';
    publishers = 'NaN';
    years = 'NaN';
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTapf(BuildContext context, String languages, String authors,
      String publishers, String years, String categories) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen, arguments: {
      'searchText':
          searchText, // Pass searchText as a parameter to the next screen
      'languages': languages != '' ? languages : 'NaN',
      'authors': authors != '' ? authors : 'NaN',
      'publishers': publishers != '' ? publishers : 'NaN',
      'years': years != '' ? years : 'NaN',
      'categories': categories != '' ? categories : 'NaN',
      'semesters': semesters != '' ? semesters : 'NaN',
      'interests': interests != '' ? interests : 'NaN',
    });
  }

  List<String> listify(String str) {
    List<String> list = str.split('-');
    return list;
  }
}
