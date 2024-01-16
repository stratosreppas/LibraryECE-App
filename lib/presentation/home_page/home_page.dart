import 'package:stratos_s_application3/presentation/home_page/widgets/penalty_box.dart';
import '../home_page/widgets/book_item_widget.dart';
import '../home_page/widgets/userprofile_item_widget.dart';
import 'package:stratos_s_application3/routes/classes/Transaction.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:stratos_s_application3/routes/classes/User.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  late String? email;
  late final User user;
  List<Transaction> activeTransactions = [];
  List<Book> selectedBooks = [];

  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
      print("Home Page: $email");
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    try {
      this.user = await fetchUserData();
      if (mounted) {
        setState(() {});
      }
      print('hi' + user.name);
      this.activeTransactions = await fetchTransactionData();
      if (mounted) {
        setState(() {});
      }

      this.selectedBooks = await fetchBookData();
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppTemplate(
            body: SingleChildScrollView(
      child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 2.v),
          child: Column(children: [
            SizedBox(height: 7.v),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 7.v),
                decoration: AppDecoration.fillPrimary
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 12.v),
                      _buildProgressBar(context),
                      SizedBox(height: 15.v),
                      _buildCurrentLoans(context)
                    ])),
            SizedBox(height: 5.v),
            _buildFavouriteBooks(context)
          ])),
    )));
  }

  /// Section Widget
  Widget _buildProgressBar(BuildContext context) {
    return SizedBox(
        height: 144.v,
        width: 304.h,
        child: Stack(alignment: Alignment.bottomRight, children: [
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 132.h,
                  margin: EdgeInsets.only(top: 5.v, right: 30.h),
                  child: Text(user.name + " " + user.surname,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeInterOnPrimary))),
          Align(
              alignment: Alignment.bottomRight,
              child: PenaltyBox(penalty: user.penalty)),
          Align(
              alignment: Alignment.topLeft,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    height: 120.adaptSize,
                    width: 120.adaptSize,
                    margin: EdgeInsets.only(bottom: 23.v),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 60.adaptSize,
                              width: 60.adaptSize,
                              decoration: AppDecoration.fillOnPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder30),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgImage1,
                                  height: 60.adaptSize,
                                  width: 60.adaptSize,
                                  radius: BorderRadius.vertical(
                                      bottom: Radius.circular(5.h)),
                                  alignment: Alignment.center))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 80.adaptSize,
                              width: 80.adaptSize,
                              child: TweenAnimationBuilder(
                                tween: Tween(
                                  begin: 0.0,
                                  end: activeTransactions.length > 2
                                      ? (7 -
                                              calculateDays(
                                                  activeTransactions[2]
                                                      .must_return_date)) /
                                          7.0
                                      : 0.0,
                                ),
                                duration: Duration(
                                    seconds:
                                        1), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor:
                                        activeTransactions.length > 2
                                            ? appTheme.gray60001
                                            : appTheme.green900,
                                    color: appTheme.green900,
                                    strokeWidth: 6,
                                  );
                                },
                              ))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 100.adaptSize,
                              width: 100.adaptSize,
                              child: TweenAnimationBuilder(
                                tween: Tween(
                                  begin: 0.0,
                                  end: activeTransactions.length > 1
                                      ? (7 -
                                              calculateDays(
                                                  activeTransactions[1]
                                                      .must_return_date)) /
                                          7.0
                                      : 0.0,
                                ),
                                duration: Duration(
                                    seconds:
                                        1), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor:
                                        activeTransactions.length > 1
                                            ? appTheme.gray500
                                            : appTheme.lime800,
                                    color: appTheme.lime800,
                                    strokeWidth: 6,
                                  );
                                },
                              ))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 120.adaptSize,
                              width: 120.adaptSize,
                              child: TweenAnimationBuilder(
                                tween: Tween(
                                  begin: 0.0,
                                  end: activeTransactions.length > 0
                                      ? (7 -
                                              calculateDays(
                                                  activeTransactions[0]
                                                      .must_return_date)) /
                                          7.0
                                      : 0.0,
                                ),
                                duration: Duration(
                                    seconds:
                                        1), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor: activeTransactions.length >
                                            0
                                        ? appTheme.blueGray100
                                        : theme.colorScheme.onPrimaryContainer,
                                    color: theme.colorScheme.onPrimaryContainer,
                                    strokeWidth: 6,
                                  );
                                },
                              )))
                    ])),
                Padding(
                    padding: EdgeInsets.only(left: 8.h, top: 65.v),
                    child: Column(children: [
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillOnPrimaryContainer
                              .copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text(
                                activeTransactions.length > 0
                                    ? calculateDays(activeTransactions[0]
                                                .must_return_date)
                                            .toString() +
                                        " days"
                                    : "- days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          )),
                      SizedBox(height: 5.v),
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillLime.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text(
                                activeTransactions.length > 1
                                    ? calculateDays(activeTransactions[1]
                                                .must_return_date)
                                            .toString() +
                                        " days"
                                    : "- days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          )),
                      SizedBox(height: 5.v),
                      Container(
                          width: 56.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.h, vertical: 1.v),
                          decoration: AppDecoration.fillLightGreen.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child: Center(
                            child: Text(
                                activeTransactions.length > 2
                                    ? calculateDays(activeTransactions[2]
                                                .must_return_date)
                                            .toString() +
                                        " days"
                                    : "- days",
                                style: CustomTextStyles.bodyMediumOnPrimary),
                          ))
                    ]))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildCurrentLoans(BuildContext context) {
    return Container(
        height: 286.v,
        width: 313.h,
        margin: EdgeInsets.only(left: 3.h),
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text("Τρέχοντες Δανεισμοί",
                      style: CustomTextStyles.titleSmallOnPrimary))),
          Align(
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          onTapTxtWidget(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: Text("Προηγ. δανεισμοί",
                                style: CustomTextStyles.labelMediumRoboto)))),
                SizedBox(height: 7.v),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index >= activeTransactions.length) {
                      return Container(
                          height: 70.v,
                          padding: EdgeInsets.fromLTRB(1.h, 6.v, 5.h, 6.v),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: appTheme.blueGray100,
                          ),
                          alignment: Alignment
                              .center, // Center both horizontally and vertically

                          child: Text(
                            "Δεν υπάρχει ενεργός δανεισμός",
                            style: CustomTextStyles.bodyMediumInterBlack900,
                            textAlign: TextAlign.center,
                          ));
                    } else {
                      return UserprofileItemWidget(
                        transaction: activeTransactions[index],
                        loanColor: index == 0
                            ? theme.colorScheme.onPrimaryContainer
                            : index == 1
                                ? appTheme.lime800
                                : appTheme.lightGreen900,
                        onTapImgImage: () {
                          onTapImgImage(context, activeTransactions[index]);
                        },
                      );
                    }
                  },
                )
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildFavouriteBooks(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 3.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 12.h, right: 21.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: Text("Αγαπημένα Βιβλία",
                                style: CustomTextStyles.titleMediumOnPrimary)),
                        GestureDetector(
                            onTap: () {
                              onTapTxtWidget1(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.v),
                                child: Text("Προβολή όλων",
                                    style: CustomTextStyles.labelMediumRoboto)))
                      ])),
              SizedBox(height: 5.v),
              Container(
                  height: 115.v,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder18),
                  child: ListView.separated(
                      padding: EdgeInsets.only(left: 4.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8.h);
                      },
                      itemCount: selectedBooks.length,
                      itemBuilder: (context, index) {
                        return BookItemWidget(
                            book: selectedBooks[index],
                            onTapImgOperatingSystemImage: () {
                              onTapImgOperatingSystemImage(context, selectedBooks[index]);
                            });
                      })),
              SizedBox(height: 1.v)
            ]));
  }

  Future<User> fetchUserData() async {
    await getEmailFromPreferences();
    User user = User();

    try {
      //print('hi');
      final response = await http.get(
          Uri.parse('http://192.168.1.187:5000/api/home/user?' + 'email=$email'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print(userData);
        if (userData.isNotEmpty) {
          user = User(
            id: userData['id'] ?? 0,
            name: userData['name'] ?? '',
            surname: userData['surname'] ?? '',
            email: userData['email'] ?? '',
            penalty: userData['penalty'] ?? '-',
            am: userData['am'] ?? '',
            phone: userData['phone'] ?? '',
            property: userData['property'] ?? '',
          );

          print('hello' + user.name);
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

  Future<List<Transaction>> fetchTransactionData() async {
    try {
      print('hi');
      int id = user.id;
      final response = await http.get(
          Uri.parse('http://192.168.1.187:5000/api/home/transactions?' + 'id=$id'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
          List<Transaction> transactions = dataList.map((map) {
            return Transaction(
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
              copies: map['copies'] ?? 0,
              book_id: map['book_id'] ?? '',
              borrow_date: map['borrow_date'] ?? '',
              must_return_date: map['must_return_date'] ?? '',
              return_date: map['return_date'] ?? '',
            );
          }).toList();

          transactions.forEach((book) {
            print('Book Title: ${book.title}');
            print('Book ID: ${book.book_id}');
          });

          if (mounted) {
            return transactions;
          }
        } else {
          print('Δεν βρέθηκαν ενεργοί δανεισμοί για αυτόν το χρήστη.');
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

  Future<List<Book>> fetchBookData() async {
    try {
      //print('hi');
      int id = user.id;
      print(id);
      final response = await http
          .get(Uri.parse('http://192.168.1.187:5000/api/home/books?' + 'id=$id'));
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
              copies: map['copies'] ?? -1,
            );
          }).toList();

          books.forEach((book) {
            print('Book Title: ${book.title}');
            print('Book Author: ${book.author}');
          });

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

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapImgOperatingSystemImage(BuildContext context, Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen, arguments: {'book': book} );
  }

  /// Navigates to the bookPageFourScreen when the action is triggered.
  onTapImgImage(BuildContext context, Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen, arguments: {'book': book});
  }

  /// Navigates to the profilePageScreen when the action is triggered.
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.profilePageScreen,
    );
  }

  /// Navigates to the favouritesPageScreen when the action is triggered.
  onTapTxtWidget1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.favouritesPageScreen);
  }
}

DateTime convertToDate(String input) {
  try {
    var d = DateFormat('EEE, dd MMM yyyy HH:mm:ss z', 'en_US').parse(input);
    return d;
  } catch (e) {
    return DateTime.now();
  }
}

int calculateDays(String dateStr) {
  DateTime date = convertToDate(dateStr);
  DateTime now = DateTime.now();
  return date.difference(now).inDays + 1;
}
