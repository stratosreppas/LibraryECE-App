import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class RadioButtonDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents;

  RadioButtonDropDownWidget({required this.header, required this.contents});

  @override
  State<RadioButtonDropDownWidget> createState() =>
      RadioButtonDropDownWidgetState();
}

class RadioButtonDropDownWidgetState extends State<RadioButtonDropDownWidget> {
  late int? selectedValue;

  @override
  void initState() {
    super.initState();
    // Set the initial value to the index of the first item
    selectedValue = widget.contents.isNotEmpty ? 0 : null;
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
          (index) => RadioListTile(
            groupValue: selectedValue,
            value: index,
            onChanged: (int? value) {
              setState(() {
                selectedValue = value;
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
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
      ),
    );
  }
}
