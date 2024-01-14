import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/filters_page_screen/widgets/checkbox_dropdown_widget.dart';
import 'package:stratos_s_application3/widgets/custom_elevated_button.dart';

import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final List<GlobalKey<CheckBoxDropDownWidgetState>> checkBoxKeys =
      List.generate(5, (index) => GlobalKey<CheckBoxDropDownWidgetState>());

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
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[1],
                      header: "Συγγραφείς",
                      contents: authorsList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[2],
                      header: "Εκδόσεις",
                      contents: publisherList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[3],
                      header: "Χρονολογία Έκδοσης",
                      contents: publicationYearList,
                    ),
                    SizedBox(height: 20.v),
                    CheckBoxDropDownWidget(
                      key: checkBoxKeys[4],
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
                    fetchData();
                  })
            ]));
  }

  Future<void> fetchData() async {
    try {
      print('hi');
      final response = await http
          .get(Uri.parse('http://10.3.24.70:5000/api/all_books/el-en'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        // Assuming dataList is a list of maps, handle each book's data
        if (dataList.isNotEmpty) {
          List<Book> books = dataList.map((map) {
            return Book(
              title: map['title'] ?? '',
              author: map['author'] ?? '',
              imageurl: map['image_url'] ?? '',
              isbn: map['isbn'] ?? '',
              subtitle: map['subtitle'] ?? '',
              publisher: map['publisher'] ?? '',
              year: map['year'] ?? '',
              language: map['language'] ?? '',
              category: map['category'] ?? '',
              edition: map['edition'] ?? '',
              dewey: map['dewey'] ?? '',
              copies: map['copies'] ?? '',
            );
          }).toList();

          // Now you have a list of Book instances, you can use or display them as needed
          books.forEach((book) {
            print('Book Title: ${book.title}');
            print('Book Author: ${book.author}');
            print('Book Image URL: ${book.imageurl}');
          });

          if (mounted) {
            onTapf(context, books); // Pass the context and books to onTapf
          }
        } else {
          print('Δεν βρέθηκαν βιβλία με τα συγκεκριμένα κριτήρια.');
        }
      } else {
        print('Σόρρυ, υπάρχει κάποιο θέμα με τη βάση.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch
      print('Error: $error');
    }
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
  onTapf(BuildContext context, List<Book> books) {
    Navigator.pushNamed(context, AppRoutes.resultPageScreen, arguments: {
      'books': books, // Pass books as a parameter to the next screen
    });
  }
}
