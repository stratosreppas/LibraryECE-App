import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class LoanComponentItemWidget extends StatelessWidget {
  final String title;
  final int bookID;
  final String loanDate;
  final String returnDate;
  final String imagePath;
  final VoidCallback? onTap;

  const LoanComponentItemWidget({
    Key? key,
    required this.title,
    required this.bookID,
    required this.loanDate,
    required this.returnDate,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      decoration: AppDecoration.fillPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 12.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 2.h,
              vertical: 3.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: imagePath,
                  height: 60.v,
                  width: 44.h,
                  radius: BorderRadius.circular(3.h),
                  margin: EdgeInsets.only(
                    top: 2.v,
                    bottom: 3.v,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                    top: 9.v,
                    bottom: 9.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90.h,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmall12,
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          bookID.toString(),
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
                        loanDate,
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "Ημερομηνία Επιστροφής",
                        style: CustomTextStyles.labelMediumBold,
                      ),
                      Text(
                        returnDate,
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
    );
  }
}
