import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class RichtooltipgridItemWidget extends StatelessWidget {
  const RichtooltipgridItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Όνομα",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 7.v),
          Text(
            "Στράτος",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
