import 'package:LeniBooks/UI/book_tile.dart';
import 'package:flutter/material.dart';
import 'UI/book_tile.dart';
import 'Model/book.dart';

void main() {
  runApp(MyApp());
}

class BookManager extends StatefulWidget {
  @override
  _BookManagerState createState() => _BookManagerState();
}

class _BookManagerState extends State<BookManager> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
    Book("Die unendliche Geschichte", 5, "Suppi!", true),
    Book("Can't Hurt Me", 5, "Suppi!", true),
    Book("12 Rules for Life", 1, "Kacke!!", false),
    Book("Tess", 3, "Meh!", false),
    Book("Money", 4, "", false),
  ];

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
    return Stack(
      children: <Widget>[
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

              return Dismissible(
                key: Key(books[i].title),
                confirmDismiss: (DismissDirection direction) async {
                  return await buildShowDismissConfirmDialog(context);
                },
                onDismissed: (direction) {
                  setState(() {
                    removeBook(b.title);
                  });
                },
                child: BookTile(
                  b.title,
                  b.rating,
                  b.note,
                  b.isFavorite,
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: newEntry,
            child: Icon(Icons.add),
          ),
        )
      ],
    );
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
}
