import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/widgets/custom_icon_button.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultBox extends StatelessWidget {

  final Book book;
  final String? email;

  final VoidCallback? onTapImgImage;

  ResultBox({
    Key? key,
    this.onTapImgImage,
    required this.book,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        onTapImgImage?.call();
      },
      child: Container(
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
                            height: 26.adaptSize,
                            width: 26.adaptSize,
                            padding: EdgeInsets.all(3.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLinkedinBlack900,
                            ),
                          ),
                          SizedBox(width: 5.h),
                          CustomIconButton(
                            onTap: () {
                              onTapFav(context);
                            },
                            height: 26.adaptSize,
                            width: 26.adaptSize,
                            padding: EdgeInsets.all(4.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgFavoriteRed90001,
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
                      maxLines: 2,
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
                  SizedBox(
                    width: 185.h,
                    child: Text(
                      (book.edition != '') ? '${book.edition}\'  Έκδοση' : "1'  Έκδοση",
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
      isDisabled: copies>0 ? false : true,
    );
  }

  onTapFav(BuildContext context) async {

      final response = await http.post(
        Uri.parse('http://192.168.1.187:5000/fav'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, //
        body: jsonEncode(<String, String>{
          'isbn': book.isbn,
          'email': email.toString(),
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        // Successful login
        String successMessage = responseData['message'];

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            successMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 16, 124, 6),
          elevation: 8,
          padding: EdgeInsets.all(8.h),
          dismissDirection: DismissDirection.down,
        ));

      } else {
        // Handle unsuccessful login (show an error message, etc.)
        String errorMessage = responseData['error'] ?? responseData['message'];
        print("Error: $errorMessage");
        // Show a snackbar or display the error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromARGB(255, 180, 14, 3),
            elevation: 8,
            padding: EdgeInsets.all(8.h),
            dismissDirection: DismissDirection.down,
          ),
        );
      }
    }
  }