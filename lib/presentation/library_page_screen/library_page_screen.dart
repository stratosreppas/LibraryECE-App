import 'package:stratos_s_application3/presentation/book_page_one_screen/book_page_one_screen.dart';
import 'package:stratos_s_application3/presentation/library_page_screen/widgets/checkbox_with_button_dropdown_widget.dart';
import '../library_page_screen/widgets/booklist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/core/utils/navigation_utils.dart';
import 'package:stratos_s_application3/widgets/custom_search_bar.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stratos_s_application3/routes/app_routes.dart';
import 'package:stratos_s_application3/constraints.dart';
import 'package:stratos_s_application3/routes/classes/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class LibraryPageScreen extends StatefulWidget {
  LibraryPageScreen({Key? key}) : super(key: key);

  @override
  State<LibraryPageScreen> createState() => _LibraryPageScreenState();
}

class _LibraryPageScreenState extends State<LibraryPageScreen> {

  late final User user;
  late final String? email;

  late final List<Book> popularBooks;
  late final List<Book> newBooks;
  late final List<Book> recommendedBooks;
  late final List<Book> favoriteBooks;
  late final List<Book> notifiedBooks;

  String semesters = 'NaN';
  String interests = 'NaN';

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
    "Μαθηματικά",
    "Διοίκηση Επιχειρήσεων",
    "Προγραμματισμός",
    "Λειτουργικά Συστήματα",
    "Ενσωματωμένα Συστήματα",
    "Ηλεκτρική Ενέργεια",
    "Θεωρητική Επιστήμη Υπολογιστών",
    "Φυσική",
    "Διαφορικές Εξισώσεις",
    "Ηλεκτρομαγνητισμός",
    "Ηλεκτροτεχνία",
    "Στατική Τεχνική Μηχανική",
    "Αριθμητική Ανάλυση",
    "Ηλεκτρομαγνητικά Πεδία",
    "Οργάνωση και Σχεδίαση Υπολογιστών",
    "Ηλεκτρικές Μετρήσεις (Κλασσικές)",
    "Ηλεκτρικές Μετρήσεις (Ηλεκτρονικές)",
    "Μικροηλεκτρονική",
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final List<GlobalKey<CheckBoxButtonDropDownWidgetState>> checkBoxKeys =
  List.generate(2, (index) => GlobalKey<CheckBoxButtonDropDownWidgetState>());

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    try {
      print('here');
      this.user = await fetchUserData();
      this.popularBooks = await fetchBookData(3);
      this.notifiedBooks = await fetchBookData(4);
      this.newBooks = await fetchBookData(2);
      this.recommendedBooks = await fetchBookData(1);
      this.favoriteBooks = await fetchBookData(0);

      if (mounted) {
        setState(() {});
      }

    } catch (error) {
      print('Error fetching data: $error');
    }
  }

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
                    header: "Εξάμηνα",
                    contents: semesterDropDown,
                    onSelectedValuesChanged: (selectedValues) {
                      semesters = selectedValues;
                    },
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
                    onSelectedValuesChanged: (selectedValues) {
                      interests = selectedValues;
                    },
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
            itemCount: 5,
            itemBuilder: (context, index) {
              return BooklistItemWidget(
                  context: context,
                  email: user.email,
                  index: index,
                  books: index == 0
                      ? recommendedBooks
                      : index == 1
                          ? favoriteBooks
                          : index == 2
                              ? newBooks
                              : index == 3
                                  ? popularBooks
                                  : notifiedBooks
              );
            }));
  }

  Future<List<Book>> fetchBookData(int homePageValue) async {
    try {
      //print('hi');
      int id = user.id;
      //print(id);
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/api/home/books'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, int>{'user_id': id, 'value': homePageValue ?? 0}),
      );
      //print('Response status code: ${response.statusCode}');
      //print('Response body: ${response.body}');

      final responseData = json.decode(response.body);
      print(responseData['data']);
      if (response.statusCode == 200) {
        final List<dynamic> dataList = responseData['data'];

        if (dataList.isNotEmpty) {
          List<Book> books = dataList.map((map) {
            return Book(
              title: map['title'].toString() ?? 'NaN',
              author: map['author'].toString() ?? 'NaN',
              imageurl: map['image_url'].toString() ?? 'NaN',
              isbn: map['isbn'].toString() ?? 'NaN',
              subtitle: map['subtitle'].toString() ?? 'NaN',
              publisher: map['publisher'].toString() ?? 'NaN',
              year: map['year'].toString() ?? 'NaN',
              language: map['language'].toString() ?? 'NaN',
              category: map['category'].toString() ?? 'NaN',
              edition: map['edition'].toString() ?? 'NaN',
              dewey: map['dewey'].toString() ?? 'NaN',
              semester: map['semester'].toString() ?? 'NaN',
              interest: map['interest'].toString() ?? 'NaN',
              copies: map['copies'] ?? -1,
              isFav: map['isFav'] != null ? map['isFav'] == 1 : false,
              isNotified: map['isNotified'] != null ? map['isNotified'] == 1 : false,
            );
          }).toList();

          // books.forEach((book) {
          //   print('Book Title: ${book.title}');
          //   print('Book Author: ${book.author}');
          // });

          if (mounted) {
            return books;
          }
        } else {
          print(
              'Δεν βρέθηκαν βιβλία με τα συγκεκριμένα κριτήρια για αυτόν το χρήστη.');
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

  Future<dynamic> getHomePageValueFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
      print("Home Page: $email");
    });
  }

  Future<User> fetchUserData() async {
    await getEmailFromPreferences();
    await getHomePageValueFromPreferences();

    User user = User();

    try {
      //print('hi');
      final response = await http.get(
          Uri.parse('${AppConstants.apiUrl}/api/home/user?' + 'email=$email'));

      //print('Response status code: ${response.statusCode}');
      //print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        //print(userData);
        if (userData.isNotEmpty) {
          user = User(
            id: userData['id'] ?? 0,
            name: userData['name'] ?? 'NaN',
            surname: userData['surname'] ?? 'NaN',
            email: userData['email'] ?? 'NaN',
            penalty: userData['penalty'] ?? '-',
            am: userData['am'] ?? 'NaN',
            phone: userData['phone'] ?? 'NaN',
            property: userData['property'] ?? 'NaN',
          );

          //print('hello' + user.name);
          if (mounted) {
            print("Succesfully fetched user data.");
            return user;
          }
        } else {
          print('Δεν βρέθηκε χρήστης με αυτό το μέιλ.');
        }
      } else {
        print('Σόρρυ, υπάρχει κάποιο θέμα με τη βάση.');
      }
    } catch (error) {
      print('Error: $error');
    }

    // Return an empty list in case of an error or no data
    return user;
  }
}