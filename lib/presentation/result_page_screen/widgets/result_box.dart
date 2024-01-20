import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/widgets/custom_icon_button.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stratos_s_application3/constraints.dart';


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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomImageView(
                      imagePath: book.imageurl,
                      height: 160.v,
                      width: 116.h,
                      radius: BorderRadius.circular(3.h),
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                    top: 4.v,
                    right: 4.h,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h), // Adjust the bottom padding as needed
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconButton(
                            onTap: () {
                              onTapLocation(context);
                            },
                            height: 26.adaptSize,
                            width: 26.adaptSize,
                            padding: EdgeInsets.all(3.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLinkedinBlack900,
                            ),
                          ),
                          SizedBox(width: 5.h),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0, right: 8.0),
                            child: LikeButton(
                              onTap: (isLiked) async {
                                onTapFav(context, isLiked);
                                book.isFav = !book.isFav;
                                return !isLiked;
                              },

                              isLiked: book.isFav,
                              animationDuration: Duration(milliseconds: 500),
                              size: 14.adaptSize,
                              circleColor: CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc),
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color: isLiked ? Colors.red : appTheme.blueGray100,
                                  size: 26.adaptSize,
                                );
                              },
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
                      (book.edition != 'NaN') ? '${book.edition}\'  Έκδοση' : "1'  Έκδοση",
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

  onTapLocation(BuildContext context) {
    Navigator.pushNamed(
        context, AppRoutes.locationPageScreen,
        arguments: {
          'book': book,
        });
  }

  onTapFav(BuildContext context, bool isFav) async {

      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}/fav'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, //
        body: jsonEncode(<String, String>{
          'isbn': book.isbn,
          'email': email.toString(),
          'isFav' : isFav ? 'true' : 'false',
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
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 16, 124, 1),
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