import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class NotificationlistItemWidget extends StatelessWidget {
  const NotificationlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text(
              "Επιστροφή Βιβλίου",
              style: CustomTextStyles.titleSmallBluegray100Bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text(
              "22/11/2023",
              style: CustomTextStyles.labelLargeCrimsonProBluegray100,
            ),
          ),
        ],
      ),
    );
  }
}
