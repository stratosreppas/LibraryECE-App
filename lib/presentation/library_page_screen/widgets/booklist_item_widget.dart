import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'book.dart';
import 'package:stratos_s_application3/routes/classes/Book.dart';

class BooklistItemWidget extends StatelessWidget {

  List<Book> books = [];
  int index;
  String email;
  dynamic context;

  BooklistItemWidget({
    Key? key,
    required this.books,
    required this.email,
    required this.index,
    required this.context,
  }) : super(key: key);


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
              // Depending on the index
              index == 0 ? "Προτείνονται για Εσάς" :
              index == 1 ? "Αγαπημένα" :
              index == 2 ? "Νέες Προσθήκες" :
              index == 3 ? "Δημοφιλή" :
              "Λαμβάνετε Ειδοποιήσεις",
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
                  books.length,
                      (index) => Container(
                    margin: EdgeInsets.only(right: 8.h), // Adjust the margin as needed
                    child: BookWidget(
                      book: books[index],
                      onTap: () {
                        onTapImgImage?.call(books[index]);
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

  onTapImgImage(Book book) {
    Navigator.pushNamed(context, AppRoutes.bookPageOneScreen, arguments: {'book': book, 'route': AppRoutes.libraryPageScreen, 'email': email});
  }
}
