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
              ],
            ),
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }
}
