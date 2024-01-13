import 'package:flutter/material.dart';
import 'Book.dart';

class Filter {

  final List<String> category;
  final List<String> language;
  final List<String> publisher;
  final List<String> author;
  final List<String> year;

  Filter({
    required this.category,
    required this.language,
    required this.publisher,
    required this.author,
    required this.year,
  });

}
