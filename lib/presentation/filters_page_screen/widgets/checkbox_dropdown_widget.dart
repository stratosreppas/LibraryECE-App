import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

class CheckBoxDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents;
  final Function(String) onSelectedValuesChanged; // Callback function
  String selectedValues = 'NaN';
  final List<String>?
      initialSelectedValues; // Optional parameter for initial selected values

  CheckBoxDropDownWidget({
    Key? key,
    required this.header,
    required this.contents,
    required this.onSelectedValuesChanged,
    this.initialSelectedValues,
  }) : super(key: key);

  @override
  State<CheckBoxDropDownWidget> createState() => CheckBoxDropDownWidgetState();
}

class CheckBoxDropDownWidgetState extends State<CheckBoxDropDownWidget> {
  List<bool?> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues with false for each content item
    checkboxValues = List<bool?>.filled(widget.contents.length, false);

    if (widget.initialSelectedValues != null) {
      for (String value in widget.initialSelectedValues!) {
        int index = widget.contents.indexOf(value);
        if (index != -1) {
          checkboxValues[index] = true;
        }
      }
    }
  }

  void clearSelection() {
    setState(() {
      checkboxValues = List<bool?>.filled(widget.contents.length, false);
    });
  }

  String getSelectedValues() {
    List<String> selectedValues = [];

    for (int i = 0; i < widget.contents.length; i++) {
      if (checkboxValues[i] == true) {
        selectedValues.add(widget.contents[i]);
      }
    }

    // Join the selected values with a '-' in between
    return selectedValues.join('-');
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
          (index) => CheckboxListTile(
            value: checkboxValues[index],
            onChanged: (bool? value) {
              setState(() {
                checkboxValues[index] = value;
                widget.onSelectedValuesChanged(getSelectedValues());
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
