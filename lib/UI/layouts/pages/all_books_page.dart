import 'package:flutter/material.dart';
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

  void removeBook(String title) {
    setState(() {
      books.removeWhere((element) => element.title == title);
    });
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

  Future<bool> buildShowDismissConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this book?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Delete")),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, i) {
        var book = books[i];

        return Dismissible(
          key: Key(books[i].title),
          confirmDismiss: (DismissDirection direction) async {
            return await buildShowDismissConfirmDialog(context);
          },
          onDismissed: (direction) {
            setState(() {
              removeBook(book.title);
            });
          },
          child: BookTile(
            book.title,
            book.rating,
            book.note,
            book.isFavorite,
          ),
        );
      },
    );
  }
}