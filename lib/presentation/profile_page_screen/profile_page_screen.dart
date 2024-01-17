import 'package:intl/intl.dart';
import '../profile_page_screen/widgets/loancomponent_item_widget.dart';
import '../profile_page_screen/widgets/richtooltipgrid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stratos_s_application3/routes/classes/Transaction.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';

class ProfilePageScreen extends StatefulWidget {
  ProfilePageScreen({Key? key}) : super(key: key);
  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? role;
  String? am;
  List<Transaction> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    getEmailAndUserData();
    getUserTransactionHistory();
  }

  Future<void> getEmailAndUserData() async {
    await getEmailFromPreferences(); // Wait for email to be fetched

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.187:5000/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email ?? "",
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        final userData = responseData['user_data'];
        setState(() {
          firstName = userData[0];
          lastName = userData[1];
          am = userData[2];
          if (userData[3] == 1)
            role = "Προπτυχιακός/ή";
          else if (userData[3] == 2)
            role = "Μεταπτυχιακός/ή";
          else if (userData[3] == 3)
            role = "Υποψήφιος/α Διδάκτωρ";
          else if (userData[3] == 4)
            role = "Καθηγητής/τρια";
          else if (userData[3] == 5)
            role = "Κατατακτήριος/α";
          else
            role = "Φοιτητής/τρια άλλης σχολής";
          phone = userData[4];
          id = userData[5];
          print("Profile Page: $firstName,$lastName,$am,$role,$phone,$id");
        });
      } else if (responseData['status'] == "error") {
        // Handle error
        print("Failed to load user data. Error: $responseData['message']");
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> getUserTransactionHistory() async {
    await getEmailAndUserData();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.187:5000/transactions_history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'id': id ?? 0,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {

        final List<dynamic> dataList = responseData;

          if (dataList.isNotEmpty) {
            transactionHistory = dataList.map((map) {
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
                book_id: map['book_id'] ?? 0,
                borrow_date: map['borrow_date'] ?? '',
                must_return_date: map['must_return_date'] ?? '',
                return_date: map['return_date'] ?? '',
              );
            }).toList();
          }

        if(mounted){
        setState(() {
          transactionHistory;
          print(transactionHistory);
        });
        }

      } else if (responseData['status'] == "failure" ||
          responseData['status'] == "error") {
        // Handle error
        print(responseData['message']);
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
      print("Profile Page: $email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the home page
        Navigator.popUntil(context, ModalRoute.withName(AppRoutes.homePage));

        return false;
      }, // Prevent default behavior (popping the current route)
      child: SafeArea(
          child: AppTemplate(
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.v),
            child: Column(children: [
              SizedBox(height: 8.v),
              _buildRichTooltipGrid(context),
              SizedBox(height: 16.v),
              _buildLoanComponentColumn(context)
            ])),
        initialIndex: 3,
      )),
    );
  }

  /// Section Widget
  Widget _buildRichTooltipGrid(BuildContext context) {
    // List of data for each item
    List<Map<String, String>> itemData = [
      {'label': 'First Name', 'value': firstName ?? ""},
      {'label': 'Last name', 'value': lastName ?? ""},
      {'label': 'E-mail', 'value': email ?? ""},
      {'label': 'Phone Number', 'value': phone ?? ""},
      {'label': 'Registration ID', 'value': am ?? ""},
      {'label': 'Role', 'value': role ?? ""},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 88.v,
          crossAxisCount: 2,
          mainAxisSpacing: 10.v,
          crossAxisSpacing: 10.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemData.length,
        itemBuilder: (context, index) {
          return RichtooltipgridItemWidget(
            labelText: itemData[index]['label']!,
            valueText: itemData[index]['value']!,
          );
        },
      ),
    );
  }

  Widget _buildLoanComponentColumn(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 40.v,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Text(
                "Ιστορικό Δανεισμών",
                style: CustomTextStyles.titleSmallOnPrimary_2,
              ),
            ),
          ),
          Container(
            height: 260.v,
            color: theme.primaryColor,
            child: ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox.shrink();
              },
              itemCount: transactionHistory.length,
              itemBuilder: (context, index) {
                return LoanComponentItemWidget(
                  transaction: transactionHistory[index],
                  onTapImgImage: () {
                    onTapthLoan(context, transactionHistory[index]);
                  },
                );
              },
            ),
          ),
          Container(
            height: 12.v,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapthLoan(BuildContext context, Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen, arguments: {
      'book': book,
      'email': email,
    });
  }
}
