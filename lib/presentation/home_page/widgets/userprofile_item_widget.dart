import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  UserprofileItemWidget({
    Key? key,
    this.onTapImgImage,
  }) : super(
          key: key,
        );

  VoidCallback? onTapImgImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(1.h, 6.v, 5.h, 6.v),
      decoration: AppDecoration.outlineOnPrimaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle21,
            height: 60.v,
            width: 45.h,
            radius: BorderRadius.circular(
              10.h,
            ),
            margin: EdgeInsets.only(left: 1.h),
            onTap: () {
              onTapImgImage!.call();
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              top: 6.v,
              bottom: 6.v,
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
                SizedBox(height: 1.v),
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
                    "23\nNov",
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
