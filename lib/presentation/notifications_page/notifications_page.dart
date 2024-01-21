import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:library_ece/constraints.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/presentation/app_template/app_template.dart';
import 'package:library_ece/presentation/notifications_page/widgets/notification_widget.dart';
import 'package:library_ece/routes/classes/Notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? email;
  List<UserNotification> notificationsHistory = [];

  @override
  void initState() {
    super.initState();
    getUserNotificationsHistory();
  }

  Future<void> getUserNotificationsHistory() async {
    await getEmailFromPreferences();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/notifications_history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email ?? "",
        }),
      );
      final responseData = json.decode(response.body);
      //print(responseData['data']);
      if (response.statusCode == 200 && responseData["status"] == "success") {
        final List<dynamic> dataList = responseData['data'];

        if (dataList.isNotEmpty) {
          setState(() {
            notificationsHistory = dataList.map((map) {
              return UserNotification(
                  notificationID: map['id'],
                  title: map['title'],
                  date: map['notification_date'],
                  content: map['content'],
                  read: map['opened']);
            }).toList();
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
    return SafeArea(
      child: AppTemplate(
        body: Padding(
          padding:
              EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.h, right: 10.h),
          child: ListView.builder(
            itemCount: notificationsHistory.length,
            itemBuilder: (context, index) {
              return NotificationWidget(
                notification: notificationsHistory[index],
                onExpand: () {
                  updateNotification(
                      notificationsHistory[index].notificationID);
                },
              );
            },
          ),
        ),
        initialIndex: 2,
      ),
    );
  }
}

Future<void> updateNotification(int notificationID) async {
  try {
    print(notificationID);
    // Your API endpoint for renewing a transaction
    final response = await http.post(
      Uri.parse('${AppConstants.apiUrl}/update_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{'notification_id': notificationID}),
    );
    final responseData = json.decode(response.body);
    // Check the response status
    if (responseData['status'] == "error") {
      print(responseData['message']);
    } else if (responseData['status'] == "success")
      print(responseData['message']);
  } catch (error) {
    // Handle any other errors that might occur during the request
    print('Error renewing loan: $error');
  }
}
