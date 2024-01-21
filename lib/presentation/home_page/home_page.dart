import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:stratos_s_application3/constraints.dart';
import 'package:stratos_s_application3/presentation/home_page/widgets/penalty_box.dart';
import 'package:stratos_s_application3/routes/classes/notification_controller.dart';
import '../home_page/widgets/book_item_widget.dart';
import '../home_page/widgets/userprofile_item_widget.dart';
import 'package:stratos_s_application3/routes/classes/Transaction.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:stratos_s_application3/routes/classes/User.dart';
import 'package:stratos_s_application3/routes/classes/Notification.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:noise_meter/noise_meter.dart'; // Import the noise_meter package
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stratos_s_application3/presentation/book_page_four_screen/book_page_four_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? email;
  late int? homePageValue;
  User user = User();
  late UserNotification notification;
  List<Transaction> activeTransactions = [];
  List<Book> selectedBooks = [];
  List<String> homePageChoices = [
    "Αγαπημένα Βιβλία",
    "Προτείνονται για εσάς",
    "Νέες Προσθήκες",
    "Δημοφιλή",
    "Λαμβάνετε Ειδοποιήσεις"
  ];

  void notificationsInitialazation() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basin Notification Channel",
      )
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "basic_channel_group",
          channelGroupName: "Basic Group")
    ]);
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
      print("Home Page: $email");
    });
  }

  Future<void> getHomePageValueFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('HomePageValue');
    setState(() {
      homePageValue = value;
      print("Home Page Value: $homePageValue");
    });
  }

  String formatDate(String dateString) {
    final inputFormat = DateFormat('E, dd MMM yyyy HH:mm:ss Z');
    final outputFormat = DateFormat('dd/MM/yyyy');

    final date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }

  Future<void> pushNotification(int notificationID) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/get_notification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'notification_id': notificationID,
          'user_id': user.id,
        }),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        List<dynamic> notificationData = responseData['data'];

        if (notificationData.isNotEmpty) {
          // Create a Notification object from the first element of notificationData
          notification = UserNotification(
            notificationID: notificationID,
            title: notificationData[0],
            date: formatDate(notificationData[1].toString()),
            content: notificationData[2],
          );
        }
        // Print the values for debugging purposes
        print("Notification ID: ${notification.notificationID}");
        print("Title: ${notification.title}");
        print("Date: ${notification.date}");
        print("Content: ${notification.content}");

        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: "basic_channel",
                title: notification.title,
                body: notification.content,
                actionType: ActionType.Default,
                backgroundColor: theme.primaryColor,
                color: appTheme.blueGray100));
      } else if (responseData['status'] == 'failure') {
        print(responseData['message']);
      }
    } catch (e) {
      // Handle any exceptions that may occur while sending the push notification
      print('Error sending push notification: $e');
    }
  }

  Future<void> checkNewNotification() async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/notification_check'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'user_id': user.id,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        int notificationID = responseData['data'];
        print(notificationID);
        await pushNotification(notificationID);
      } else if (responseData['status'] == 'failure' ||
          responseData['status'] == 'error') {
        print(responseData['message']);
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  void startTimer() {
    const Duration duration = const Duration(seconds: 10);
    Timer.periodic(duration, (Timer timer) {
      checkNewNotification();
    });
  }

  @override
  void initState() {
    super.initState();
    notificationsInitialazation();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    startTimer();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    try {
      this.user = await fetchUserData();
      if (mounted) {
        setState(() {});
      }
      print('hi ' + user.name);
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
    NotificationController.setAppContext(context);
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
                                      : 1.0,
                                ),
                                duration: Duration(
                                    milliseconds:
                                        1000), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor: appTheme.gray60001,
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
                                      : 1.0,
                                ),
                                duration: Duration(
                                    milliseconds:
                                        1200), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor: appTheme.gray500,
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
                                      : 1.0,
                                ),
                                duration: Duration(
                                    milliseconds:
                                        1400), // Set the duration of the animation
                                builder: (context, double value, child) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    value: value,
                                    backgroundColor: appTheme.blueGray100,
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
                        onTapRenewButton: () {
                          renewTransaction(activeTransactions[index]);
                        },
                        isButtonEnabled: activeTransactions[index].renew,
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
                            child: Text(homePageChoices[homePageValue ?? 0],
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
                              onTapImgOperatingSystemImage(
                                  context, selectedBooks[index]);
                            });
                      })),
              SizedBox(height: 1.v)
            ]));
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

  Future<List<Transaction>> fetchTransactionData() async {
    try {
      int id = user.id;
      final response = await http.get(Uri.parse(
          '${AppConstants.apiUrl}/api/home/transactions?' + 'id=$id'));

      //print('Response status code: ${response.statusCode}');
      //print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
          List<Transaction> transactions = dataList.map((map) {
            return Transaction(
                transactionID: map['transaction_id'],
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
                copies: map['copies'] ?? 0,
                isFav: map['isFav'] != null ? map['isFav'] == 1 : false,
                isNotified: map['isNotified'] != null ? map['isNotified'] == 1 : false,
                book_id: map['book_id'] ?? 'NaN',
                borrow_date: map['borrow_date'] ?? 'NaN',
                must_return_date: map['must_return_date'] ?? 'NaN',
                return_date: map['return_date'] ?? 'NaN',
                renew: map['renew']);
          }).toList();

          // transactions.forEach((book) {
          //   print('Book Title: ${book.title}');
          //   print('Book ID: ${book.book_id}');
          // });

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

  Future<void> renewTransaction(Transaction transaction) async {
    try {
      // Your API endpoint for renewing a transaction
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/renew'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, int>{'transaction_id': transaction.transactionID}),
      );
      final responseData = json.decode(response.body);
      // Check the response status
      if (response.statusCode == 200 && responseData['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            responseData['message'],
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 16, 124, 6),
          elevation: 8,
          padding: EdgeInsets.all(8.h),
          duration: Duration(milliseconds: 900),
          dismissDirection: DismissDirection.down,
        ));
      } else if (responseData['status'] == "disabled") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
                child: Text(
              'Loan has already been renewed once',
              style: TextStyle(fontSize: 14.h),
            )),
            duration: Duration(milliseconds: 900),
            backgroundColor: appTheme.red900,
            dismissDirection: DismissDirection.down,
          ),
        );
      } else {
        // Handle the error case
        print("$responseData['message']: $responseData['error']");
      }
    } catch (error) {
      // Handle any other errors that might occur during the request
      print('Error renewing loan: $error');
    }
  }

  /// Navigates to the bookPageThreeScreen when the action is triggered.
  onTapImgOperatingSystemImage(BuildContext context, Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen,
        arguments: {'book': book, 'route': AppRoutes.homePage, 'email': email});
  }

  /// Navigates to the bookPageFourScreen when the action is triggered.
  onTapImgImage(BuildContext context, Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen,
        arguments: {'book': book, 'route': AppRoutes.homePage, 'email': email });
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