import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class RichtooltipgridItemWidget extends StatelessWidget {
  final String labelText;
  final String valueText;

  const RichtooltipgridItemWidget({
    Key? key,
    required this.labelText,
    required this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 2.v),
          Text(
            valueText,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
