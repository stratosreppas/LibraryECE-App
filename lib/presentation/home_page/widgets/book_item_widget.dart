import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/routes/classes/Book.dart';

class BookItemWidget extends StatelessWidget {
  final Book book;
  final VoidCallback onTapImgOperatingSystemImage;

  const BookItemWidget({
    Key? key,
    required this.onTapImgOperatingSystemImage,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.v,
      width: 75.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(1, 5), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: book.imageurl,
            height: 115.v,
            width: 75.h,
            radius: BorderRadius.circular(10.h),
            alignment: Alignment.center,
            onTap: onTapImgOperatingSystemImage,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 1.v),
                  SizedBox(
                    width: 47.h,
                    child: Text(
                      book.title ?? "",
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
