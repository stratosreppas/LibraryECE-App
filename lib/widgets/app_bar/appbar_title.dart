import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            text,
            style: CustomTextStyles.bodyLargeLexend.copyWith(
              color: appTheme.blueGray100,
            ),
          ),
        ),
      ),
    );
  }
}
