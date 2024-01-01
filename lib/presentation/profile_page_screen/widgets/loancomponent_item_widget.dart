import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class LoancomponentItemWidget extends StatelessWidget {
  LoancomponentItemWidget({
    Key? key,
    this.onTapthLoan,
  }) : super(
          key: key,
        );

  VoidCallback? onTapthLoan;

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
                  imagePath: ImageConstant.imgRectangle2160x44,
                  height: 60.v,
                  width: 44.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  margin: EdgeInsets.only(
                    top: 2.v,
                    bottom: 3.v,
                  ),
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
                        width: 108.h,
                        child: Text(
                          "ΕΙΣΑΓΩΓΗ ΣΤΙΣ ΤΗΛΕΠΙΚΟΙΝΩΝΙΕΣ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmall12,
                        ),
                      ),
                      Opacity(
                        opacity: 0.4,
                        child: Text(
                          "2345",
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
                        "05/11/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "Ημερομηνία Επιστροφής",
                        style: CustomTextStyles.labelMediumBold,
                      ),
                      Text(
                        "12/11/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.v),
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
                  imagePath: ImageConstant.imgRectangle2111,
                  height: 60.v,
                  width: 44.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  margin: EdgeInsets.only(
                    left: 1.h,
                    top: 3.v,
                    bottom: 2.v,
                  ),
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
                        width: 80.h,
                        child: Text(
                          "ΣΧΕΔΙΑΣΜΟΣ ΑΛΓΟΡΙΘΜΩΝ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmall12,
                        ),
                      ),
                      Opacity(
                        opacity: 0.4,
                        child: Text(
                          "5743",
                          style: CustomTextStyles.bodyMediumInterBlack900,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.v),
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
                        "23/10/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "Ημερομηνία Επιστροφής",
                        style: CustomTextStyles.labelMediumBold,
                      ),
                      Text(
                        "30/10/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.v),
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
                  imagePath: ImageConstant.imgRectangle2112,
                  height: 60.v,
                  width: 44.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  margin: EdgeInsets.only(
                    left: 1.h,
                    top: 2.v,
                    bottom: 3.v,
                  ),
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
                        width: 85.h,
                        child: Text(
                          "ΔΙΚΤΥΩΣΗ ΥΠΟΛΟΓΙΣΤΩΝ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmall12,
                        ),
                      ),
                      Opacity(
                        opacity: 0.4,
                        child: Text(
                          "4325",
                          style: CustomTextStyles.bodyMediumInterBlack900,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.v),
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
                        "23/10/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "Ημερομηνία Επιστροφής",
                        style: CustomTextStyles.labelMediumBold,
                      ),
                      Text(
                        "30/10/2023",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.v),
          GestureDetector(
            onTap: () {
              onTapthLoan!.call();
            },
            child: Container(
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
                    imagePath: ImageConstant.imgRectangle21115x75,
                    height: 60.v,
                    width: 44.h,
                    radius: BorderRadius.circular(
                      3.h,
                    ),
                    margin: EdgeInsets.only(
                      left: 1.h,
                      top: 2.v,
                      bottom: 3.v,
                    ),
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
                          width: 76.h,
                          child: Text(
                            "ΛΕΙΤΟΥΡΓΙΚΑ ΣΥΣΤΗΜΑΤΑ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmall12,
                          ),
                        ),
                        Opacity(
                          opacity: 0.4,
                          child: Text(
                            "7454",
                            style: CustomTextStyles.bodyMediumInterBlack900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.v),
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
                          "26/09/2023",
                          style: theme.textTheme.bodySmall,
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          "Ημερομηνία Επιστροφής",
                          style: CustomTextStyles.labelMediumBold,
                        ),
                        Text(
                          "18/10/2023",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 13.v),
          SizedBox(
            height: 73.v,
            width: 313.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 73.v,
                    width: 313.h,
                    decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(
                        9.h,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.v),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgBook,
                          height: 44.v,
                          width: 36.h,
                          radius: BorderRadius.circular(
                            3.h,
                          ),
                          margin: EdgeInsets.only(
                            top: 8.v,
                            bottom: 5.v,
                          ),
                        ),
                        Container(
                          height: 59.v,
                          width: 262.h,
                          margin: EdgeInsets.only(left: 7.h),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: 132.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                  child: Text(
                                    "ΠΡΟΓΡΑΜΜΑΤΙΣΜΟΣ ΜΕ ΤΗ  C++",
                                    maxLines: null,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.bodySmall12,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Opacity(
                                  opacity: 0.4,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 2.h,
                                      bottom: 2.v,
                                    ),
                                    child: Text(
                                      "5742",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles
                                          .bodyMediumInterBlack900,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "26/09/2023",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 5.v),
                                    Text(
                                      "Ημερομηνία Επιστροφής",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.labelMediumBold,
                                    ),
                                    Text(
                                      "12/10/2023",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 7.h),
                                  child: Text(
                                    "Ημερομηνία Δανεισμού",
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyles.labelMediumBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
