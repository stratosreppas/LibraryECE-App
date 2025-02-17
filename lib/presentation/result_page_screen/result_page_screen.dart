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
import 'package:stratos_s_application3/constraints.dart';
import 'package:stratos_s_application3/routes/classes/Filter.dart';

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
  String semesters = 'NaN';
  String interests = 'NaN';

  Filter filters = Filter(
    category: [],
    language: [],
    publisher: [],
    author: [],
    year: [],
  );

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

    if (args.containsKey('semesters')) {
      semesters = args['semesters'];
    }

    if (args.containsKey('interests')) {
      interests = args['interests'];
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
          this.filters = setFilters(this.books);
        });
      }
    });
  }

  @override
  void didPopNext() {
    // This method is called when the current route has been popped off,
    // and the previous route (ResultPageScreen) is revealed.

    // You can trigger a reload here.
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
                if (languages != 'NaN' ||
                    authors != 'NaN' ||
                    publishers != 'NaN' ||
                    years != 'NaN' ||
                    categories != 'NaN' ||
                    semesters != 'NaN' ||
                    interests != 'NaN')
                  SizedBox(height: 16.v),
                if (languages != 'NaN' ||
                    authors != 'NaN' ||
                    publishers != 'NaN' ||
                    years != 'NaN' ||
                    categories != 'NaN' ||
                    semesters != 'NaN' ||
                    interests != 'NaN')
                  Row(
                    children: [
                      SizedBox(
                          width: 16
                              .h), // Adds a horizontal space of 16 times the value of 'h'
                      Text('Αναζήτηση με βάση τα φίλτρα: '),
                    ],
                  ),
                SizedBox(
                    height: 5
                        .v), // Adds a horizontal space of 16 times the value of 'h'
                Row(
                  children: [
                    // Displays a text indicating a search with filters
                    SizedBox(
                        width: 5
                            .h), // Adds a horizontal space of 16 times the value of 'h'
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 350.h, // Adjust the width as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  if (languages != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(languages),
                                      ),
                                    ), // Displays languages followed by a comma
                                  if (authors != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(authors),
                                      ),
                                    ), // Displays authors followed by a comma
                                  if (publishers != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(publishers),
                                      ),
                                    ), // Displays publishers followed by a comma
                                  if (years != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(years),
                                      ),
                                    ),
                                  if (categories != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(categories),
                                      ),
                                    ),
                                  if (semesters != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(semesters),
                                      ),
                                    ),
                                  if (interests != 'NaN')
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: appTheme.deepPurple50014,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(interests),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                for (Book book in books)
                  Column(
                    children: [
                      SizedBox(height: 16.v),
                      ResultBox(
                          book: book,
                          email: email,
                          onTapImgImage: () {
                            Navigator.pushNamed(
                                context, AppRoutes.bookPageOneScreen,
                                arguments: {
                                  'route': AppRoutes.resultPageScreen,
                                  'book': book,
                                  'email': email,
                                  'languages': languages,
                                  'authors': authors,
                                  'publishers': publishers,
                                  'years': years,
                                  'categories': categories,
                                  'searchText': searchText,
                                  'semesters': semesters,
                                  'interests': interests,
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
      await getEmailFromPreferences();
      //print('hi');
      final response = await http.get(Uri.parse(
          '${AppConstants.apiUrl}/api/all_books?' +
              'searchText=$searchText&categories=$categories&authors=$authors&publishers=$publishers&years=$years&languages=$languages&semesters=$semesters&interests=$interests&email=$email'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
          List<Book> books = dataList.map((map) {
            return Book(
              title: map['title'] ?? 'NaN',
              author: map['author'] ?? 'NaN',
              imageurl: map['image_url'] ?? 'NaN',
              isbn: map['isbn'] ?? 'NaN',
              subtitle: map['subtitle'] ?? 'NaN',
              publisher: map['publisher'] ?? 'NaN',
              year: map['year'] ?? 'NaN',
              language: map['language'] ?? 'NaN',
              category: map['category'] ?? 'NaN',
              edition: map['edition'] ?? 'NaN',
              dewey: map['dewey'] ?? 'NaN',
              semester: map['semester'] ?? 'NaN',
              interest: map['interest'] ?? 'NaN',
              copies: map['copies'] ?? 'NaN',
              isFav: map['isFav'] != null ? map['isFav'] == 1 : false,
              isNotified:
                  map['isNotified'] != null ? map['isNotified'] == 1 : false,
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
      'languages': languages,
      'authors': authors,
      'publishers': publishers,
      'years': years,
      'categories': categories,
      'filters': filters,
      'semesters': semesters,
      'interests': interests,
    });
  }

  Filter setFilters(List<Book> books) {
    Filter filters = Filter(
      category: [],
      language: [],
      publisher: [],
      author: [],
      year: [],
    ); // Assuming Filter is a class you have defined

    for (Book book in books) {
      filters.language = addUnique(book.language, filters.language);
      filters.author = addUnique(book.author, filters.author);
      filters.year = addUnique(book.year, filters.year);
      filters.publisher = addUnique(book.publisher, filters.publisher);
      filters.category = addUnique(book.category, filters.category);
    }

    print(filters.year);
    return filters;
  }

  List<String> addUnique(String? str, List<String> list) {
    List<String> list1 = list;
    if (str != null && str != 'NaN' && !list.contains(str)) {
      list1.add(str); // Make a mutable copy
    }
    return list1;
  }
}
