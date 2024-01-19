import 'Book.dart';

class Transaction extends Book {
  final int book_id;
  final String borrow_date;
  final String must_return_date;
  final String return_date;
  late final int transactionID;
  late final int renew;

  Transaction({
    required this.book_id,
    required this.borrow_date,
    required this.must_return_date,
    required this.return_date,
    this.transactionID = 0,
    this.renew = 1,
    required String title,
    required String subtitle,
    required String isbn,
    required String imageurl,
    required String author,
    required String publisher,
    required String year,
    required String language,
    required String category,
    required String edition,
    required String dewey,
    required int copies,
    required bool isFav,
  }) : super(
          title: title,
          subtitle: subtitle,
          isbn: isbn,
          imageurl: imageurl,
          author: author,
          publisher: publisher,
          year: year,
          language: language,
          category: category,
          edition: edition,
          dewey: dewey,
          copies: copies,
          isFav: isFav,
        );
}
