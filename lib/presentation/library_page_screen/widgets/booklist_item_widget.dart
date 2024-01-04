import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'book.dart';

class BooklistItemWidget extends StatelessWidget {
  BooklistItemWidget({
    Key? key,
    this.onTapImgImage,
  }) : super(key: key);

  final VoidCallback? onTapImgImage;

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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  6,
                      (index) => Container(
                    margin: EdgeInsets.only(right: 8.h), // Adjust the margin as needed
                    child: BookWidget(
                      onTap: () {
                        onTapImgImage?.call();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }
}
