import 'dart:convert';
import 'book.dart';

class BookCollection{
  //TODO: implement version for possible future changes?
  List<Book> _books;
  List<Book> get books => _books;

  BookCollection(this._books);

  BookCollection.fromJson(String json){
    Map<String, dynamic> decoded = jsonDecode(json);
    List<Book> decodedBooks = List<Book>();

    for(var bookJson in decoded["books"]){
      var book = Book.fromJson(bookJson as String);
      decodedBooks.add(book);
    }

    _books = decodedBooks;
  }

  String toJson(){
    List<String> encodedBooks = List<String>();

    for(var book in _books){
      encodedBooks.add(book.toJson());
    }

    Map<String, dynamic> encodedCollection = { "books": encodedBooks };
    return jsonEncode(encodedCollection);
  }
}