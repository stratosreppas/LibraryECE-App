import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            radius: BorderRadius.circular(3.h),
            alignment: Alignment.center,
            onTap: onTap,
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
    );
  }
}
