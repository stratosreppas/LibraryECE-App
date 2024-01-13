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

class _NotificationWidgetState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  bool _hasBeenExpanded = false;
  bool _hasBeenColored = false;

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
              _hasBeenColored = true;
            });
            _controller.forward(); // Start the animation when expanding
          } else if (_hasBeenExpanded && !value) {
            setState(() {
              _hasBeenExpanded = false;
            });
            _controller.reverse(); // Reverse the animation when collapsing
          }
        },
        collapsedIconColor: appTheme.blueGray100,
        backgroundColor:
            _hasBeenColored // Change color if _hasBeenColored is true
                ? theme.primaryColor.withOpacity(0.7)
                : theme.primaryColor,
        collapsedBackgroundColor: _hasBeenColored
            ? theme.primaryColor.withOpacity(0.7)
            : theme.primaryColor,
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
              widget.content,
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
}
