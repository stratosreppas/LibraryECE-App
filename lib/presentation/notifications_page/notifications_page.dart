import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/presentation/app_template/app_template.dart';
import 'package:stratos_s_application3/presentation/notifications_page/widgets/notification_widget.dart';

class NotificationsPage extends StatelessWidget {
  // Define a list of notifications with different values
  final List<Map<String, String>> notificationsData = [
    {
      'header': "Χριστουγεννιάτικο Ωράριο Λειτουργίας Βιβλιοθήκης ΣΗΜΜΥ",
      'date': "27/12/2023",
      'content':
          "Η βιβλιοθήκη κατά τη διάρκεια των διακοπών των Χριστουγέννων θα είναι ανοιχτή 27-29/12/2023 και 3-5/1/2024 και ώρες 09.00-15.00."
    },
    {
      'header': "Another Notification",
      'date': "01/01/2024",
      'content': "This is another notification content."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppTemplate(
        body: Padding(
          padding:
              EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.h, right: 10.h),
          child: ListView.builder(
            itemCount: notificationsData.length,
            itemBuilder: (context, index) {
              // Build NotificationWidget based on data from the list
              return NotificationWidget(
                header: notificationsData[index]['header'] ?? '',
                date: notificationsData[index]['date'] ?? '',
                content: notificationsData[index]['content'] ?? '',
              );
            },
          ),
        ),
        initialIndex: 2,
      ),
    );
  }
}
