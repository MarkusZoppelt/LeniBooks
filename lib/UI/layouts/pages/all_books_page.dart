import 'package:flutter/cupertino.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/UI/elements/book_tile.dart';

class AllBooksPage extends StatefulWidget{
  @override
  AllBooksPageState createState() => AllBooksPageState();
}

class AllBooksPageState extends State<AllBooksPage>{
  List<Book> books = [
    Book("Die unendliche Geschichte", 5, "Suppi!", true),
    Book("Can't Hurt Me", 5, "Suppi!", true),
    Book("12 Rules for Life", 1, "Kacke!!", false),
    Book("Tess", 3, "Meh!", false),
    Book("Money", 4, "", false),
  ];

  Book b = Book("Money", 4, "", false);

  void addBook(String title) {
    setState(() {
      books.add(Book(title, 0, "", false));
    });
    Navigator.of(context).pop();
  }

  void removeAllBooks() {
    setState(() {
      books.clear();
      books = [
        Book("Die unendliche Geschichte", 5, "Suppi!", true),
        Book("Can't Hurt Me", 5, "Suppi!", true),
        Book("12 Rules for Life", 1, "Kacke!!", false),
        Book("Tess", 3, "Meh!", false),
        Book("Money", 4, "", false),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, i) {
        var b = books[i];
        return BookTile(b.title, b.rating, b.note, b.isFavorite);
      },
    );
  }
}