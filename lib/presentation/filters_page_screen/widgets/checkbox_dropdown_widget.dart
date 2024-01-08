import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class CheckBoxDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents; // Updated to take a list of contents

  CheckBoxDropDownWidget({required this.header, required this.contents});

  @override
  State<CheckBoxDropDownWidget> createState() => _CheckBoxDropDownWidgetState();
}

class _CheckBoxDropDownWidgetState extends State<CheckBoxDropDownWidget> {
  late List<bool?> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues with false for each content item
    checkboxValues = List<bool?>.filled(widget.contents.length, false);
  }

  @override
  Widget build(BuildContext context) {
    print("checkboxValues: $checkboxValues");
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
          (index) => CheckboxListTile(
            value: checkboxValues[index],
            onChanged: (bool? value) {
              setState(() {
                checkboxValues[index] = value;
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
            activeColor: appTheme.blueGray100,
            checkColor: theme.primaryColor,
            side: BorderSide(color: appTheme.blueGray100, width: 2.h),
          ),
        ),
      ),
    );
  }
}
