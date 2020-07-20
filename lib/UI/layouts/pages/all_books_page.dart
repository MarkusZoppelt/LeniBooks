import 'package:LeniBooks/UI/elements/big_book_tile.dart';
import 'package:flutter/material.dart';
import 'package:LeniBooks/Data/book_storage.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/UI/elements/book_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllBooksPage extends StatefulWidget{
  @override
  AllBooksPageState createState() => AllBooksPageState();
}

class AllBooksPageState extends State<AllBooksPage>{
  List<Book> books = List<Book>();
  List<StaggeredTile> staggeredTiles = List<StaggeredTile>();

  AllBooksPageState(){
    BookStorage(onBooksChanged: setBooks);
    var storageBooks = BookStorage.instance.allBooks;
    books = storageBooks != null ? storageBooks : List<Book>();
  }

  @override
  void dispose() {
    BookStorage.instance.removeOnBooksChangedCallback(setBooks);
    super.dispose();
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

  Widget buildHeaderTile(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "My Books", 
        style: TextStyle(
          color: Colors.teal[300],
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildFooterTile(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "No more Books :(", 
        style: TextStyle(
          color: Colors.teal[300],
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> buildAllBooks(BuildContext context){
    List<Widget> bookWidgets = List<Widget>();
    staggeredTiles = List<StaggeredTile>();

    bookWidgets.add(buildHeaderTile(context));
    staggeredTiles.add(StaggeredTile.fit(1));

    for(var book in books){
      BigBookTile tile = BigBookTile(book.title, book.rating, book.note, book.isFavorite);
      bookWidgets.add(tile);
      staggeredTiles.add(StaggeredTile.fit(1));
    }

    bookWidgets.add(buildFooterTile(context));
    staggeredTiles.add(StaggeredTile.fit(1));

    return bookWidgets;
  }

  @override
  Widget build(BuildContext context) {
    var bookTiles = buildAllBooks(context);

    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        new SliverStaggeredGrid.count(
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          staggeredTiles: staggeredTiles,
          children: bookTiles,
        ),
      ],
    );
  }
}