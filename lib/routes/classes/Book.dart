
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
  bool isFav;
  bool isNotified;


  Book({
  this.title = 'NaN',
  this.subtitle = 'NaN',
  this.isbn = 'NaN',
  this.imageurl = 'NaN',
  this.author = 'NaN',
  this.publisher = 'NaN',
  this.year = 'NaN',
  this.language = 'NaN',
  this.category = 'NaN',
  this.edition = 'NaN',
  this.dewey = 'NaN',
  this.copies = 0,
  this.isFav = false,
  this.isNotified = false,
  });
}
