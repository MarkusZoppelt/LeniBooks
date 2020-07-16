import 'dart:convert';

class Book {
  List<Book> books;
  String title;
  String author;
  int rating;
  String note;
  int bookId;

  Book(this.title, this.author, this.rating, this.note, this.bookId);

  factory Book.fromJSON(Map<String, dynamic> parsedJSON) {
    return Book(
      parsedJSON['title'],
      parsedJSON['author'],
      parsedJSON['id'],
      parsedJSON['rating'],
      parsedJSON['note'],
    );
  }
}
