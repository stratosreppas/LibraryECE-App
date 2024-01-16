
class Book {
  final String title;
  final String subtitle;
  final String isbn;
  final String imageurl;
  final String author;
  final String publisher;
  final String year;
  final String language;
  final String category;
  final String edition;
  final String dewey;
  final int copies;


  Book({
    required this.title,
    required this.isbn,
    required this.imageurl,
    required this.author,
    required this.publisher,
    required this.year,
    required this.language,
    required this.category,
    required this.edition,
    required this.dewey,
    required this.subtitle,
    required this.copies,
  });
}
