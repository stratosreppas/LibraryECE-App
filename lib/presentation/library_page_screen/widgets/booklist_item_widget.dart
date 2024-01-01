import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class BooklistItemWidget extends StatelessWidget {
  BooklistItemWidget({
    Key? key,
    this.onTapImgImage,
  }) : super(
          key: key,
        );

  VoidCallback? onTapImgImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Προτείνονται για Εσάς",
              style: CustomTextStyles.bodyLargeInterOnPrimary,
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            margin: EdgeInsets.only(left: 1.h),
            padding: EdgeInsets.symmetric(vertical: 4.v),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Row(
              children: [
                Container(
                  height: 170.v,
                  width: 120.h,
                  margin: EdgeInsets.only(bottom: 2.v),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle21170x120,
                        height: 170.v,
                        width: 120.h,
                        radius: BorderRadius.circular(
                          3.h,
                        ),
                        alignment: Alignment.center,
                        onTap: () {
                          onTapImgImage!.call();
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.v),
                          decoration: AppDecoration.fillBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderBL5,
                          ),
                          child: SizedBox(
                            width: 120.h,
                            child: Text(
                              "ΠΡΟΓΡΑΜΜΑΤΙΣΜΟΣ ΣΕ UNIX",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 170.v,
                  width: 120.h,
                  margin: EdgeInsets.only(
                    left: 9.h,
                    bottom: 2.v,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle217,
                        height: 170.v,
                        width: 120.h,
                        radius: BorderRadius.circular(
                          3.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.h,
                            vertical: 5.v,
                          ),
                          decoration: AppDecoration.fillBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderBL5,
                          ),
                          child: SizedBox(
                            width: 117.h,
                            child: Text(
                              "ΝΕΥΡΩΝΙΚΑ ΔΙΚΤΥΑ ΚΑΙ ΜΗΧΑΝΙΚΗ ΜΑΘΗΣΗ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 170.v,
                  width: 69.h,
                  margin: EdgeInsets.only(
                    left: 9.h,
                    bottom: 1.v,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle218,
                        height: 170.v,
                        width: 120.h,
                        radius: BorderRadius.circular(
                          3.h,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 36.v,
                          width: 120.h,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 35.v,
                                  width: 120.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.blueGray100,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(3.h),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 42.h,
                                  margin: EdgeInsets.only(left: 26.h),
                                  child: Text(
                                    "ΣΥΓΧΡΟΝΑ ΛΕΙΤΟΥΡΓΙΚΑ ΣΥΣΤΗΜΑΤΑ",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 24,
                ),
                Spacer(
                  flex: 75,
                ),
                Container(
                  height: 170.v,
                  width: 1.h,
                  margin: EdgeInsets.only(bottom: 2.v),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle219,
                        height: 170.v,
                        width: 120.h,
                        radius: BorderRadius.circular(
                          3.h,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: AppDecoration.fillBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderBL5,
                          ),
                          child: SizedBox(
                            width: 120.h,
                            child: Text(
                              "ΑΝΑΓΝΩΡΙΣΗ ΠΡΟΤΥΠΩΝ ΚΑΙ ΜΗΧΑΝΙΚΗ ΜΑΘΗΣΗ",
                              maxLines: null,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 170.v,
                  width: 1.h,
                  margin: EdgeInsets.only(bottom: 2.v),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle2110,
                        height: 170.v,
                        width: 120.h,
                        radius: BorderRadius.circular(
                          3.h,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: AppDecoration.fillBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderBL5,
                          ),
                          child: SizedBox(
                            width: 120.h,
                            child: Text(
                              "ΗΛΕΚΤΡΙΚΕΣ ΜΗΧΑΝΕΣ AC-DC",
                              maxLines: null,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }
}
