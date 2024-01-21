import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/routes/classes/Transaction.dart';
import 'package:intl/intl.dart';

class LoanComponentItemWidget extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTapImgImage;

  LoanComponentItemWidget({
    Key? key,
    required this.transaction,
    this.onTapImgImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapImgImage?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        decoration: AppDecoration.fillPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 12.v),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 1.h,
                vertical: 3.v,
              ),
              decoration: AppDecoration.fillBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CustomImageView(
                      imagePath: transaction.imageurl ?? ImageConstant.imgBook,
                      height: 60.v,
                      width: 44.h,
                      margin: EdgeInsets.only(
                        top: 2.v,
                        bottom: 3.v,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.h,
                      top: 9.v,
                      bottom: 9.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90.h,
                          child: Text(
                            transaction.title ?? "Err: title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmall12,
                          ),
                        ),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            transaction.book_id.toString() ?? "Err: book_id",
                            style: CustomTextStyles.bodyMediumInterBlack900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.h,
                      bottom: 6.v,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ημερομηνία Δανεισμού",
                            style: CustomTextStyles.labelMediumBold,
                          ),
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          formatDate(transaction.borrow_date),
                          style: theme.textTheme.bodySmall,
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          "Ημερομηνία Επιστροφής",
                          style: CustomTextStyles.labelMediumBold,
                        ),
                        Text(
                          formatDate(transaction.return_date),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    final inputFormat = DateFormat('E, dd MMM yyyy HH:mm:ss Z');
    final outputFormat = DateFormat('dd/MM/yyyy');

    final date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }
}
