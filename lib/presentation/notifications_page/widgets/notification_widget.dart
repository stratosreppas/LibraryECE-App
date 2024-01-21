import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/routes/classes/Notification.dart';

class NotificationWidget extends StatefulWidget {
  final UserNotification notification;
  final VoidCallback? onExpand;

  NotificationWidget({required this.notification, this.onExpand});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  bool _hasBeenExpanded = false;
  //bool _hasBeenColored = false;
  Color? backgroundColor = theme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          widget.notification.title,
          style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 14.h,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          formatDate(widget.notification.date),
          style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 12.h,
              fontFamily: "Crimson Pro"),
        ),
        onExpansionChanged: (value) {
          if (!_hasBeenExpanded && value) {
            if (widget.notification.read == 0) {
              widget.onExpand?.call();
              setState(() {
                _hasBeenExpanded = true;
                backgroundColor = theme.primaryColor.withOpacity(0.7);
              });
            } else {
              setState(() {
                _hasBeenExpanded = true;
              });
            }

            _controller.forward(); // Start the animation when expanding
          } else if (_hasBeenExpanded && !value) {
            setState(() {
              _hasBeenExpanded = false;
            });
            _controller.reverse(); // Reverse the animation when collapsing
          }
        },
        collapsedIconColor: appTheme.blueGray100,
        backgroundColor: widget.notification.read == 0
            ? backgroundColor
            : theme.primaryColor.withOpacity(0.7),
        collapsedBackgroundColor: widget.notification.read == 0
            ? backgroundColor
            : theme.primaryColor.withOpacity(0.7),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        childrenPadding: EdgeInsets.all(8.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        iconColor: appTheme.blueGray100,
        children: [
          SizeTransition(
            sizeFactor: _animation,
            child: Text(
              widget.notification.content,
              style: TextStyle(
                color: appTheme.blueGray100,
                fontSize: 13.h,
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    final inputFormat = DateFormat('E, dd MMM yyyy HH:mm:ss Z');
    final outputFormat = DateFormat('dd/MM/yyyy');

    final date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }
}
