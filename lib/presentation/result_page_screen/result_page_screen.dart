import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/widgets/custom_search_bar.dart';
import '../result_page_screen/widgets/result_box.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_floating_button.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  late String? email;

  String searchText = 'NaN';
  String languages = 'NaN';
  String categories = 'NaN';
  String authors = 'NaN';
  String publishers = 'NaN';
  String years = 'NaN';

  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
      print("Home Page: $email");
    });
  }

  @override
  void initState() {
    super.initState();
    getEmailFromPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the 'languages' parameter from the arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args);
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

    if (args.containsKey('searchText')) {
      // Get the value associated with the 'languages' key
      searchText = args['searchText'];
    }

    // Print or use the 'languages' value
    print('Languages: $languages');

    fetchData().then((fetchedBooks) {
      if (mounted) {
        setState(() {
          this.books = fetchedBooks;
        });
      }
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
                  child: CustomSearchBar(
                    searchController: searchController,
                  ),
                ),
                Row(
                  // write a text here
                  children: [
                    SizedBox(width: 16.h),
                    Text('Αποτελέσματα για: ' + searchText),
                  ],
                ),
                SizedBox(height: 16.v),
                Row(
                  // write a text here
                  children: [
                    SizedBox(width: 16.h),
                    Text('Αναζήτηση με βάση τα φίλτρα: ' + languages),
                  ],
                ),
                for (Book book in books)
                  Column(
                    children: [
                      SizedBox(height: 16.v),
                      ResultBox(book: book, email: email, onTapImgImage: () {
                        Navigator.pushNamed(
                            context, AppRoutes.bookPageOneScreen,
                            arguments: {
                              'book': book,
                              'email': email,
                            });
                      }),
                    ],
                  ),
                SizedBox(height: 16.v),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
        initialIndex: 1,
      ),
    );
  }

  Future<List<Book>> fetchData() async {
    try {
      //print('hi');
      final response = await http.get(Uri.parse(
          'http://192.168.1.187:5000/api/all_books?' +
              'searchText=$searchText&categories=$categories&authors=$authors&publishers=$publishers&years=$years&languages=$languages'));

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
    Navigator.pushNamed(context, AppRoutes.filtersPageScreen, arguments: {
      'searchText': searchText,
      'languages': languages, // Pass books as a parameter to the next screen
    });
  }
}
