import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class SwitchDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents;

  SwitchDropDownWidget({required this.header, required this.contents});

  @override
  State<SwitchDropDownWidget> createState() => SwitchDropDownWidgetState();
}

class SwitchDropDownWidgetState extends State<SwitchDropDownWidget> {
  List<bool> switchValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues with false for each content item
    switchValues = List<bool>.filled(widget.contents.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Center(
          child: Text(
            widget.header,
            style: TextStyle(
              color: appTheme.blueGray100,
              fontSize: 16.h,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        collapsedIconColor: appTheme.blueGray100,
        backgroundColor: theme.primaryColor,
        collapsedBackgroundColor: theme.primaryColor,
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        childrenPadding: EdgeInsets.all(8.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h)),
        iconColor: appTheme.blueGray100,
        children: List.generate(
          widget.contents.length,
          (index) => SwitchListTile(
            value: switchValues[index],
            onChanged: (bool value) {
              setState(() {
                switchValues[index] = value;
              });
            },
            title: Center(
              child: Text(
                widget.contents[index],
                style: TextStyle(
                  color: appTheme.blueGray100,
                  fontSize: 14.h,
                ),
              ),
            ),
            activeColor: theme.primaryColor,
            activeTrackColor: appTheme.blueGray100,
            inactiveTrackColor: appTheme.blueGray100,
            inactiveThumbColor: theme.primaryColor,
            trackOutlineColor: MaterialStateProperty.all(appTheme.blueGray100),
          ),
        ),
      ),
    );
  }
}
