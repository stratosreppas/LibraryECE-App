import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

// ignore: must_be_immutable
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({
    Key? key,
    required this.text,
    this.margin,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
            color: appTheme.blueGray100,
            fontSize: 16.h,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
