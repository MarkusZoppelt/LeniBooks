import 'book.dart';

class BookCollection {
  static Book sampleBook =
      Book("Die unendliche Geschichte", "Michael Ende", 5, "Supi Frutti", 1);

  List<Book> books = [sampleBook];

  BookCollection();

  List<Book> getUserBooks() {
    return books;
  }

  void addBook(Book book) {
    books.add(book);
  }

  void addSampleBook() {
    var b = books.last;
    books.add(Book(b.title, b.author, b.rating, b.note, b.bookId + 1));
    print("added sample book");
  }
}
