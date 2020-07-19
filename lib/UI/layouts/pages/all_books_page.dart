import 'package:flutter/material.dart';
import 'package:LeniBooks/Data/book_storage.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/UI/elements/book_tile.dart';

class AllBooksPage extends StatefulWidget{
  @override
  AllBooksPageState createState() => AllBooksPageState();
}

class AllBooksPageState extends State<AllBooksPage>{
  List<Book> books = List<Book>();

  AllBooksPageState(){
    BookStorage(onBooksChanged: setBooks);
    books = List<Book>();
  }

  void setBooks(List<Book> newBooks){
    setState(() {
      books = newBooks;
    });
  }

  void addBook(String title, {int rating = 0, String note = "", bool isFavourite = false}) {
    setState(() {
      Book book = Book(title, rating, note, isFavourite);
      BookStorage.instance.addBook(book);
      books = BookStorage.instance.allBooks;
    });
    Navigator.of(context).pop();
  }

  void removeBook(String title) {
    setState(() {
      Book book = books.firstWhere((element) => element.title == title);
      BookStorage.instance.deleteBook(book);
      books = BookStorage.instance.allBooks;
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