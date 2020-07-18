import 'package:flutter/material.dart';
import '../Model/book.dart';
import 'detailed_book_view.dart';

class BookTile extends StatelessWidget {
  final String title;
  final int rating;
  final String notes;
  final bool isFavorite;

  const BookTile(
    this.title,
    this.rating,
    this.notes,
    this.isFavorite,
  );

  @override
  Widget build(BuildContext context) {
    Book b = Book(this.title, this.rating, this.notes, this.isFavorite);

    String rating = "";
    for (var i = 0; i < this.rating; i++) {
      rating += "⭐";
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            Book bookToRemove = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedBookView(
                  b: b,
                ),
              ),
            );
            if (bookToRemove is Book) {
              print("Remove!");
            }
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: TileWidget(title: title, rating: rating, notes: notes),
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({
    Key key,
    @required this.title,
    @required this.rating,
    @required this.notes,
  }) : super(key: key);

  final String title;
  final String rating;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // height: 100,
          decoration: ShapeDecoration.fromBoxDecoration(
            BoxDecoration(
              // color: Colors.grey,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.red],
              ),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                ),
              ],
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: ContentWidget(title: title, rating: rating, notes: notes),
          ),
        ),
      ],
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key key,
    @required this.title,
    @required this.rating,
    @required this.notes,
  }) : super(key: key);

  final String title;
  final String rating;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          this.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Text(rating),
        Text(
          this.notes.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
