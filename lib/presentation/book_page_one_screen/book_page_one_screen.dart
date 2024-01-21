import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/widgets/custom_outlined_button.dart';
import 'package:library_ece/presentation/app_template/app_template.dart';
import 'package:library_ece/routes/classes/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:library_ece/constraints.dart';

// ignore_for_file: must_be_immutable
class BookPageOneScreen extends StatefulWidget {
  BookPageOneScreen({Key? key}) : super(key: key);

  @override
  State<BookPageOneScreen> createState() => _BookPageOneScreenState();
}

class _BookPageOneScreenState extends State<BookPageOneScreen> {
  final GlobalKey<LikeButtonState> likeButtonKey = GlobalKey<LikeButtonState>();

  bool? isFavorite;

  Book book = Book();

  String? email;

  String authors = 'NaN';
  String languages = 'NaN';
  String categories = 'NaN';
  String publishers = 'NaN';
  String years = 'NaN';
  String searchText = 'NaN';

  String semesters = 'NaN';
  String interests = 'NaN';

  dynamic route;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the 'languages' parameter from the arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args);

    if (args.containsKey('book')) {
      // Get the value associated with the 'languages' key
      book = args['book'];
      isFavorite = book.isFav;
    }

    if (args.containsKey('email')) {
      // Get the value associated with the 'languages' key
      email = args['email'];
    }

    if (args.containsKey('authors')) {
      // Get the value associated with the 'languages' key
      authors = args['authors'];
    }

    if (args.containsKey('languages')) {
      // Get the value associated with the 'languages' key
      languages = args['languages'];
    }

    if (args.containsKey('categories')) {
      // Get the value associated with the 'languages' key
      categories = args['categories'];
    }

    if (args.containsKey('publishers')) {
      // Get the value associated with the 'languages' key
      publishers = args['publishers'];
    }

    if (args.containsKey('years')) {
      // Get the value associated with the 'languages' key
      years = args['years'];
    }

    if (args.containsKey('searchText')) {
      // Get the value associated with the 'languages' key
      searchText = args['searchText'];
    }

    if (args.containsKey('semesters')) {
      // Get the value associated with the 'languages' key
      semesters = args['semesters'];
    }

    if (args.containsKey('interests')) {
      // Get the value associated with the 'languages' key
      interests = args['interests'];
    }

    if (args.containsKey('route')) {
      // Get the value associated with the 'languages' key
      route = args['route'];
    }

    print(
        'Book: ${book.title} ${book.subtitle} ${book.edition} ${book.isbn} ${book.author} ${book.category} ${book.publisher} ${book.year} ${book.language} ${book.imageurl} ${book.copies} ${book.isFav}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the home page
        Navigator.pop(context);

        Navigator.pushNamed(context, route, arguments: {
          'email': email,
          'authors': authors,
          'languages': languages,
          'categories': categories,
          'publishers': publishers,
          'years': years,
          'searchText': searchText,
          'semesters': semesters,
          'interests': interests
        });
        return false;
      },
      child: SafeArea(
        child: AppTemplate(
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
            child: Column(
              children: [
                SizedBox(height: 4.v),
                _buildAvailableCopies(context),
                SizedBox(height: 6.v),
                SizedBox(
                  child: Container(
                    height: 11.v,
                    width: 340.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.h)),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      decoration: AppDecoration.fillPrimary,
                      child: Column(
                        children: [
                          SizedBox(height: 13.v),
                          _buildExtendableRich2(context, 'Τίτλος', book.title),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Υπότιτλος', book.subtitle),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Έκδοση', book.edition),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(context, 'ISBN', book.isbn),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Συγγραφέας', book.author),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Κατηγορία', book.category),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Εκδότης', book.publisher),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Έτος έκδοσης', book.year.toString()),
                          SizedBox(height: 12.v),
                          _buildExtendableRich2(
                              context, 'Γλώσσα', book.language),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 11.v,
                  width: 340.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          initialIndex: 1,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAvailableCopies(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 14.h, right: 11.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                  imagePath: book.imageurl,
                  height: 169.v,
                  width: 121.h,
                  radius: BorderRadius.circular(10.h)),
              Padding(
                  padding: EdgeInsets.only(left: 6.h, bottom: 7.v),
                  child: Column(children: [
                    CustomOutlinedButton(
                        width: 166.h,
                        text: "Διαθέσιμα Αντίτυπα: " + book.copies.toString(),
                        margin: EdgeInsets.only(right: 5.h),
                        isDisabled: book.copies > 0 ? false : true,
                        alignment: Alignment.centerRight),
                    SizedBox(height: 10.v),
                    if (book.copies == 0)
                      GestureDetector(
                        onTap: () {
                          onTapNotify(context, book.isNotified);
                          book.isNotified = !book.isNotified;
                          setState(() {});
                        },
                        child: SizedBox(
                            height: 25.v,
                            width: 140.h,
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgRectangle30,
                                height: 25.v,
                                width: 186.h,
                                radius: BorderRadius.circular(12.h),
                                alignment: Alignment.center,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 4.v, bottom: 1.v),
                                            child: Text(
                                                "Eιδοποίηση: " +
                                                    (book.isNotified
                                                        ? "ON"
                                                        : "OFF"),
                                                style: CustomTextStyles
                                                    .bodySmallRobotoOnPrimary11)),
                                        CustomImageView(
                                            imagePath: ImageConstant.imgBell,
                                            color: book.isNotified
                                                ? appTheme.green900
                                                : appTheme.blueGray100,
                                            height: 20.v,
                                            width: 20.h,
                                            margin: EdgeInsets.only(left: 10.h))
                                      ]))
                            ])),
                      ),
                    if (book.copies == 0) SizedBox(height: 36.v),
                    if (book.copies != 0) SizedBox(height: 61.v),
                    GestureDetector(
                      onTap: () {
                        onTapFav(context, isFavorite!);
                        // Toggle the isFav property or perform any other necessary actions
                        isFavorite = !isFavorite!;
                        likeButtonKey.currentState?.onTap();
                      },
                      child: SizedBox(
                        height: 25.v,
                        width: 186.h,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgRectangle30,
                              height: 25.v,
                              width: 186.h,
                              radius: BorderRadius.circular(12.h),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 6.v, bottom: 4.v),
                                      child: Text(
                                        "Πρόσθεσε στα αγαπημένα",
                                        style: CustomTextStyles
                                            .bodySmallRobotoOnPrimary11,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, left: 15.0),
                                      child: LikeButton(
                                        isLiked: book.isFav,
                                        key: likeButtonKey,
                                        onTap: (isLiked) async {
                                          // The onTapFav action is now handled by the GestureDetector
                                          // You can remove or keep this method based on your requirements
                                          return !isLiked;
                                        },
                                        animationDuration:
                                            Duration(milliseconds: 500),
                                        size: 24.adaptSize,
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
                                            color: isLiked
                                                ? Colors.red
                                                : appTheme.blueGray100,
                                            size: 24.adaptSize,
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
                    ),
                    SizedBox(height: 14.v),
                    GestureDetector(
                      onTap: () {
                        onTapImgImage(context);
                      },
                      child: SizedBox(
                          height: 25.v,
                          width: 186.h,
                          child: Stack(alignment: Alignment.center, children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgRectangle30,
                                height: 25.v,
                                width: 186.h,
                                radius: BorderRadius.circular(12.h),
                                alignment: Alignment.center,
                                onTap: () {
                                  onTapImgImage(context);
                                }),
                            Align(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 4.v, bottom: 1.v),
                                          child: Text("Βρες το στη Βιβλιοθήκη",
                                              style: CustomTextStyles
                                                  .bodySmallRobotoOnPrimary11)),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgPlace,
                                          color: appTheme.blueGray100,
                                          height: 20.v,
                                          width: 20.h,
                                          margin: EdgeInsets.only(left: 22.h))
                                    ]))
                          ])),
                    )
                  ]))
            ]));
  }

  /// Section Widget
  Widget _buildExtendableRich(BuildContext context, String title, String text) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 14.v),
              Container(
                  margin: EdgeInsets.only(right: 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: theme.textTheme.titleSmall),
                        SizedBox(height: 6.v),
                        SizedBox(
                            width: 272.h,
                            child: Text(text,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(height: 1.43)))
                      ]))
            ]));
  }

  /// Common widget
  Widget _buildExtendableRich2(
      BuildContext context, String title, String text) {
    return Container(
        width: 308.h,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 11.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.v),
              Text(title, style: theme.textTheme.titleSmall),
              SizedBox(height: 7.v),
              Text(text, style: theme.textTheme.bodyMedium)
            ]));
  }

  /// Navigates to the locationPageScreen when the action is triggered.
  onTapImgImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.locationPageScreen,
        arguments: {'book': book});
  }

  onTapNotify(BuildContext context, bool isNotified) async {
    final response = await http.post(
      Uri.parse('${AppConstants.apiUrl}/notify_book'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //
      body: jsonEncode(<String, String>{
        'isbn': book.isbn,
        'email': email.toString(),
        'isNotified': isNotified ? 'true' : 'false',
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

  onTapFav(BuildContext context, bool isFav) async {
    final response = await http.post(
      Uri.parse('${AppConstants.apiUrl}/fav'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //
      body: jsonEncode(<String, String>{
        'isbn': book.isbn,
        'email': email.toString(),
        'isFav': isFav ? 'true' : 'false',
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
