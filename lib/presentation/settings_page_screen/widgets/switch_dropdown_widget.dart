import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:library_ece/core/app_export.dart';

class SwitchDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents;
  final List<String>? savedValues;

  SwitchDropDownWidget(
      {required this.header,
      required this.contents,
      required this.savedValues});

  @override
  State<SwitchDropDownWidget> createState() => SwitchDropDownWidgetState();
}

class SwitchDropDownWidgetState extends State<SwitchDropDownWidget> {
  List<bool> switchValues = [];
  List<String>? tempValues;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializePreferences();
    initializeSwitchValues();
  }

  void initializeSwitchValues() {
    switchValues = widget.savedValues!.map((value) => value == "1").toList();
    tempValues = List<String>.from(widget.savedValues!);
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
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
                if (widget.header == "Σελίδα Βιβλιοθήκης") {
                  if (value == true) {
                    tempValues![index] = "1";
                    prefs.setStringList('libraryPageValues', tempValues!);
                  } else {
                    tempValues![index] = "0";
                    prefs.setStringList('libraryPageValues', tempValues!);
                  }
                } else if (widget.header == "Ειδοποιήσεις") {
                  if (value == true) {
                    tempValues![index] = "1";
                    prefs.setStringList('notificationsValues', tempValues!);
                  } else {
                    tempValues![index] = "0";
                    prefs.setStringList('notificationsValues', tempValues!);
                  }
                }
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
