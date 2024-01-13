import 'package:flutter/material.dart';
import 'Book.dart';

class Transaction extends Book{

  final String book_id;
  final String borrow_date;
  final String must_return_date;
  final String return_date;

  Transaction({
    required this.book_id,
    required this.borrow_date,
    required this.must_return_date,
    required this.return_date,
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
  );
}
