import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class BookItemWidget extends StatelessWidget {
  BookItemWidget({
    Key? key,
    this.onTapImgOperatingSystemImage,
  }) : super(
          key: key,
        );

  VoidCallback? onTapImgOperatingSystemImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.v,
      width: 75.h,
      decoration: AppDecoration.outlineBlack,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle21115x75,
            height: 115.v,
            width: 75.h,
            radius: BorderRadius.circular(
              3.h,
            ),
            alignment: Alignment.center,
            onTap: () {
              onTapImgOperatingSystemImage!.call();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 11.h,
                vertical: 3.v,
              ),
              decoration: AppDecoration.fillBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.customBorderBL5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1.v),
                  SizedBox(
                    width: 47.h,
                    child: Text(
                      "ΛΕΙΤΟΥΡΓΙΚΑ ΣΥΣΤΗΜΑΤΑ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.interBlack900Bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
