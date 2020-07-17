import 'package:LeniBooks/UI/book_tile.dart';
import 'package:flutter/material.dart';
import 'UI/book_tile.dart';
import 'UI/user_input.dart';
import 'Model/book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Leni Books",
      theme: ThemeData(
        backgroundColor: Colors.transparent,
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AllBooksPage(),
    );
  }
}

class AllBooksPage extends StatefulWidget {
  @override
  _AllBooksState createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooksPage> {
  List<Book> books = [
    Book("Die unendliche Geschichte", 5, "Suppi!", true, 1),
    Book("Can't Hurt Me", 5, "Suppi!", true, 2),
    Book("12 Rules for Life", 1, "Kacke!!", false, 3),
    Book("Tess", 3, "Meh!", false, 4),
    Book("Money", 4, "", false, 6),
  ];

  Book b = Book("Money", 4, "", false, 6);

  void addBook(String title) {
    setState(() {
      books.add(Book(title, 0, "", false, 6));
    });
    Navigator.of(context).pop();
  }

  void removeAllBooks() {
    setState(() {
      books.clear();
      books = [
        Book("Die unendliche Geschichte", 5, "Suppi!", true, 1),
        Book("Can't Hurt Me", 5, "Suppi!", true, 2),
        Book("12 Rules for Life", 1, "Kacke!!", false, 3),
        Book("Tess", 3, "Meh!", false, 4),
        Book("Money", 4, "", false, 6),
      ];
    });
  }

  void newEntry() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            onSubmitted: addBook,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/bookshelf.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("All Books"),
          backgroundColor: Colors.pink,
        ),
        body: ListView.builder(
          // gridDelegate:
          //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: books.length,
          itemBuilder: (context, i) {
            var b = books[i];
            return BookTile(b.title, b.rating, b.note, b.isFavorite);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: newEntry,
          child: Icon(Icons.add),
        ),
      )
    ]);
  }
}
