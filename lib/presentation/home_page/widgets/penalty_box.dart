import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:intl/intl.dart';

class PenaltyBox extends StatelessWidget {
  PenaltyBox({Key? key, required this.penalty}) : super(key: key);

  final String penalty;

  @override
  Widget build(BuildContext context) {
    bool isPenaltyNegative = penalty == "-";
//
    return Container(
      margin: EdgeInsets.only(right: 8.h, top: 1.v),
      padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 6.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isPenaltyNegative ? appTheme.lightGreen900 : appTheme.red90001.withOpacity(0.8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              "Ποινή",
              style: CustomTextStyles.bodyLargeInterOnPrimary,
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              toDate(penalty) ?? "   -   ",
              style: CustomTextStyles.bodyLargeInterOnPrimary,
            ),
          ),
          SizedBox(height: 10.v),
        ],
      ),
    );
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
  DateTime Date = convertToDate(dateStr);
  DateTime now = DateTime.now();
  return Date.difference(now).inDays;
}

String toDate(String dateStr) {
  DateTime Date = convertToDate(dateStr);
  switch (Date.month) {
    case 1:
      return Date.day.toString() + " Jan";
    case 2:
      return Date.day.toString() + " Feb";
    case 3:
      return Date.day.toString() + " Mar";
    case 4:
      return Date.day.toString() + " Apr";
    case 5:
      return Date.day.toString() + " May";
    case 6:
      return Date.day.toString() + " Jun";
    case 7:
      return Date.day.toString() + " Jul";
    case 8:
      return Date.day.toString() + " Aug";
    case 9:
      return Date.day.toString() + " Sep";
    case 10:
      return Date.day.toString() + " Oct";
    case 11:
      return Date.day.toString() + " Nov";
    case 12:
      return Date.day.toString() + " Dec";
    default:
      return "-";
  }
}