import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class CheckBoxButtonDropDownWidget extends StatefulWidget {
  final String header;
  final List<String> contents;
  final Function(String) onSelectedValuesChanged; // Callback function


  CheckBoxButtonDropDownWidget(
      {Key? key, required this.header, required this.contents, required this.onSelectedValuesChanged,})
      : super(key: key);

  @override
  State<CheckBoxButtonDropDownWidget> createState() =>
      CheckBoxButtonDropDownWidgetState();
}

class CheckBoxButtonDropDownWidgetState
    extends State<CheckBoxButtonDropDownWidget> {
  List<bool?> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues with false for each content item
    checkboxValues = List<bool?>.filled(widget.contents.length, false);

  }

  void clearSelection() {
    setState(() {
      checkboxValues = List<bool?>.filled(widget.contents.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.h),
      child: Column(
        children: [
          ExpansionTile(
            title: Center(
              child: Text(
                widget.header,
                style: TextStyle(
                  color: appTheme.blueGray100,
                  fontSize: 14.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            collapsedIconColor: appTheme.blueGray100,
            backgroundColor: theme.primaryColor,
            collapsedBackgroundColor: theme.primaryColor,
            collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.h)),
            childrenPadding: EdgeInsets.all(2.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.h),
            ),
            iconColor: appTheme.blueGray100,
            children: [
              Container(
                height:
                    200.h, // Set a height to limit the number of visible items
                child: ListView.builder(
                  itemCount: widget.contents.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
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
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onTapf(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(appTheme.red900),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(150.h, 30.h)), // Change the color here
                ),
                child: Text(
                  'Εφαρμογή',
                  style: TextStyle(color: appTheme.blueGray100),
                ),
              ),
              SizedBox(height: 4.h)
            ],
          ),
        ],
      ),
    );
  }

  /// Navigates to the resultPageScreen when the action is triggered.
  onTapf(BuildContext context) {
    String header;
    switch (widget.header) {
      case 'Εξάμηνα':
        header = 'semesters';
        break;
      case 'Κατηγορίες':
        header = 'interests';
        break;
      default:
        header = 'NaN';
    }
    Navigator.pushNamed(context, AppRoutes.resultPageScreen, arguments: {
      '$header': getSelectedValues(),
    });
  }


  String getSelectedValues() {

    List<String> selectedValues = [];

    for (int i = 0; i < widget.contents.length; i++) {
      if (checkboxValues[i] == true) {
        selectedValues.add(widget.contents[i]);
      }
    }
    return selectedValues.join('-');
  }

}
