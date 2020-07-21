import 'package:flutter_test/flutter_test.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/Data/book_storage.dart';

void main() {
  var books = BookStorage.instance.allBooks;

  var book = Book("Tester Book", 5, "Tester Notes", true);
  var false_book = Book("Tester Book", 7, "Tester Notes", true);

  test('Book should be added', () {
    BookStorage.instance.addBook(book);
    books = BookStorage.instance.allBooks;

    expect(books.contains(book), true);
  });

  test('Test if book with 1 > rating < 5 can be added', () {
    BookStorage.instance.addBook(false_book);
    books = BookStorage.instance.allBooks;

    expect(books.contains(book), false);
  });

  test('Book should be deleted', () {
    BookStorage.instance.deleteBook(book);
    books = BookStorage.instance.allBooks;

    expect(books.contains(book), false);
  });

  // TODO
  // test for book storage in file
}
