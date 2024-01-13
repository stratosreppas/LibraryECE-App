import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/widgets/custom_icon_button.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';

class ResultBox extends StatelessWidget {

  final Book book;

  ResultBox({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      padding: EdgeInsets.symmetric(vertical: 7.v),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 160.v,
            width: 116.h,
            margin: EdgeInsets.only(left: 14.h),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CustomImageView(
                  imagePath: book.imageurl,
                  height: 160.v,
                  width: 116.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4.v,
                      right: 4.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconButton(
                          height: 25.adaptSize,
                          width: 25.adaptSize,
                          padding: EdgeInsets.all(2.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgLinkedinBlack900,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgFavoriteRed90001,
                          height: 20.v,
                          width: 22.h,
                          margin: EdgeInsets.only(
                            left: 7.h,
                            top: 3.v,
                            bottom: 1.v,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 7.h,
              top: 10.v,
              bottom: 5.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 194.h,
                  child: Text(
                    book.title,
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodyMediumOnPrimary_1.copyWith(
                      height: 1.71,
                    ),
                  ),
                ),
                SizedBox(
                  width: 185.h,
                  child: Text(
                    book.author,
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallRobotoOnPrimary.copyWith(
                      height: 2.00,
                    ),
                  ),
                ),
                SizedBox(height: 41.v),
                _buildAvailableCopies2(context, book.copies),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAvailableCopies2(BuildContext context, int copies) {
    return CustomOutlinedButton(
      height: 27.v,
      width: 166.h,
      text: "Διαθέσιμα Αντίτυπα: $copies",
      margin: EdgeInsets.only(left: 3.h),
    );
  }

}
