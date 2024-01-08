import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class NotificationWidget extends StatefulWidget {
  final String header;
  final String date;
  final String content;

  NotificationWidget(
      {required this.header, required this.date, required this.content});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool _hasBeenExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          widget.header,
          style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 14.h,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          widget.date,
          style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 12.h,
              fontFamily: "Crimson Pro"),
        ),
        onExpansionChanged: (value) {
          if (!_hasBeenExpanded && value) {
            setState(() {
              _hasBeenExpanded = true;
            });
          }
        },
        collapsedIconColor: appTheme.blueGray100,
        backgroundColor: !_hasBeenExpanded
            ? theme.primaryColor
            : theme.primaryColor.withOpacity(0.7),
        collapsedBackgroundColor: !_hasBeenExpanded
            ? theme.primaryColor
            : theme.primaryColor.withOpacity(0.7),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        childrenPadding: EdgeInsets.all(8.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        iconColor: appTheme.blueGray100,
        children: [
          Text(
            widget.content,
            style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 13.h,
            ),
          )
        ],
      ),
    );
  }
}
