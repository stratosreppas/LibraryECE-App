import 'package:stratos_s_application3/presentation/app_template/app_template.dart';

import '../result_page_screen/widgets/twelve_item_widget.dart';
import '../result_page_screen/widgets/result_box.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/home_page/home_page.dart';
import 'package:stratos_s_application3/presentation/notifications_page/notifications_page.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_bottom_bar.dart';
import 'package:stratos_s_application3/widgets/custom_floating_button.dart';
import 'package:stratos_s_application3/widgets/custom_icon_button.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPageScreen extends StatefulWidget {
  ResultPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<ResultPageScreen> createState() => _ResultPageScreenState();
}

class _ResultPageScreenState extends State<ResultPageScreen> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  TextEditingController searchController = TextEditingController();

  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((fetchedBooks) {
      setState(() {
        this.books = fetchedBooks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppTemplate(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.v),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: SearchBar(
                              backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                              // Return the color for the default state
                              return theme.primaryColor;
                            },
                            ),
                            controller: searchController,
                            hintText: " Αναζητήστε εδώ",
                            hintStyle:
                            MaterialStateProperty.resolveWith<TextStyle?>(
                  (Set<MaterialState> states) {
                                // Return the style for the default state
                                return TextStyle(
                  color: appTheme.blueGray100,
                  fontSize: 15.h,
                                ); // Customize with your color
                              },
                            ),
                            trailing: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                  onTap: () {
                    // Navigate when the trailing icon is tapped
                    Navigator.pushNamed(
                        context, AppRoutes.resultPageScreen);
                  },
                  child: Icon(
                    Icons.search_outlined,
                    color: appTheme.blueGray100,
                  ),
                                ),
                              ),
                            ],
                            onSubmitted: (String string) {
                              Navigator.pushNamed(
                  context, AppRoutes.resultPageScreen);
                            },
                            textStyle:
                            MaterialStateProperty.resolveWith<TextStyle?>(
                  (Set<MaterialState> states) {
                                // Return the style for the default state
                                return TextStyle(
                    color: appTheme
                        .blueGray100); // Customize with your color
                              },
                            ),
                          ),
                ),
                for (Book book in books)
                  Column(
                    children: [
                      SizedBox(height: 16.v),
                      ResultBox(book: book),
                    ],
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Future<List<Book>> fetchData() async {
    try {
      print('hi');
      final response = await http.get(Uri.parse('http://10.3.26.23:5000/api/all_books/el-en'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

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

          books.forEach((book) {
            print('Book Title: ${book.title}');
            print('Book Author: ${book.author}');
            print('Book Image URL: ${book.imageurl}');
          });

          if (mounted) {
            return books;
          }
        } else {
          print('Δεν βρέθηκαν βιβλία με τα συγκεκριμένα κριτήρια.');
        }
      } else {
        print('Σόρρυ, υπάρχει κάποιο θέμα με τη βάση.');
      }
    } catch (error) {
      print('Error: $error');
    }

    // Return an empty list in case of an error or no data
    return [];
  }


  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 60,
      width: 60,
      backgroundColor: appTheme.deepPurple50014,
      child: CustomImageView(
        imagePath: ImageConstant.imgFilterAlt,
        height: 30.0.v,
        width: 30.0.h,
      ),
      onTap: () {
        onTapFloatingActionButton(context);
      },
    );
  }

/// Navigates to the filtersPageScreen when the action is triggered.
  onTapFloatingActionButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.filtersPageScreen);
  }
}


