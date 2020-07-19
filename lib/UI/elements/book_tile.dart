import 'package:flutter/material.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/UI/layouts/views/detailed_book_view.dart';

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

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
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
          padding: EdgeInsets.all(10),
          child: TileWidget(
            title: title,
            rating: rating,
            notes: notes,
            isFavorite: isFavorite,
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatefulWidget {
  TileWidget({
    Key key,
    @required this.title,
    @required this.rating,
    @required this.notes,
    @required this.isFavorite,
  }) : super(key: key);

  final String title;
  final String rating;
  final String notes;
  bool isFavorite;

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  void toggleFavorite() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.favorite_border;
    if (widget.isFavorite) {
      icon = Icons.favorite;
    }
    return Column(
      children: <Widget>[
        Container(
          // height: 100,
          decoration: ShapeDecoration.fromBoxDecoration(
            BoxDecoration(
              color: Colors.red[50],
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2.0,
                  offset: Offset(0.0, 3.0)
                ),
              ],
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    icon,
                    color: Colors.red,
                  ),
                  onPressed: toggleFavorite),
              Container(
                width: MediaQuery.of(context).size.width / 2 + 50,
                child: ContentWidget(
                    title: widget.title,
                    rating: widget.rating,
                    notes: widget.notes),
              ),
            ],
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
        Text(rating),
        Text(
          this.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
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
