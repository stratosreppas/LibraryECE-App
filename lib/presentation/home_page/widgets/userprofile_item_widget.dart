import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/routes/classes/Transaction.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTapImgImage;
  final Color? loanColor; // Added color parameter

  UserprofileItemWidget({
    Key? key,
    required this.transaction,
    this.onTapImgImage,
    this.loanColor, // Added color parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(1.h, 6.v, 5.h, 6.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: appTheme.blueGray100,
        border: Border(
          left: BorderSide(
            color: loanColor ?? appTheme.lightGreen900,
            width: 5.h,
          ),
        ),
      ), // Added rounded corners
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60.v,
            width: 45.h,
            margin: EdgeInsets.only(left: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CustomImageView(
              imagePath: transaction.imageurl ?? ImageConstant.imgBook,
              height: 60.v,
              width: 45.h,
              radius: BorderRadius.circular(10.h),
              onTap: () {
                onTapImgImage!.call();
              },
            ),
          )
,
          Padding(
            padding: EdgeInsets.only(
              left: 5.h,
              top: 6.v,
              bottom: 6.v,
            ),
            child: GestureDetector(
              onTap: () {
                onTapImgImage!.call();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 108.h,
                    child: Text(
                      transaction.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodySmall12,
                    ),
                  ),
                  SizedBox(height: 1.v),
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      transaction.book_id.toString() ?? "",
                      style: CustomTextStyles.bodyMediumInterBlack900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.v),
            padding: EdgeInsets.symmetric(
              horizontal: 7.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.outlineBlack900.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 2.v),
                SizedBox(
                  width: 25.h,
                  child: Text(
                    toDate(transaction.must_return_date) ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodyMediumInterOnPrimary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 13.h,
              top: 3.v,
              bottom: 17.v,
            ),
            child: Column(
              children: [
                Text(
                  "Ανανέωση",
                  style: CustomTextStyles.interBlack900,
                ),
                SizedBox(height: 4.v),
                Container(
                  height: 27.adaptSize,
                  width: 27.adaptSize,
                  padding: EdgeInsets.all(4.h),
                  decoration: AppDecoration.fillLightGreen.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder15,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgReboot,
                    height: 19.v,
                    width: 18.h,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

DateTime convertToDate(String input) {
  try {
    var d = DateFormat('EEE, dd MMM yyyy HH:mm:ss z', 'en_US').parse(input);
    return d;
  } catch (e) {
    return DateTime.now();
  }
}

int calculateDays(String dateStr) {
  DateTime Date = convertToDate(dateStr);
  DateTime now = DateTime.now();
  return Date.difference(now).inDays;
}

String toDate(String dateStr) {
  DateTime Date = convertToDate(dateStr);
  switch(Date.month){
    case 1:
      return Date.day.toString() + " Jan";
    case 2:
      return Date.day.toString() + " Feb";
    case 3:
      return Date.day.toString() + " Mar";
    case 4:
      return Date.day.toString() + " Apr";
    case 5:
      return Date.day.toString() + " May";
    case 6:
      return Date.day.toString() + " Jun";
    case 7:
      return Date.day.toString() + " Jul";
    case 8:
      return Date.day.toString() + " Aug";
    case 9:
      return Date.day.toString() + " Sep";
    case 10:
      return Date.day.toString() + " Oct";
    case 11:
      return Date.day.toString() + " Nov";
    case 12:
      return Date.day.toString() + " Dec";
    default:
      return "Invalid Month";
  }
}