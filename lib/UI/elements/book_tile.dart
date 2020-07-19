import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String title;
  final int rating;
  final String notes;
  final bool isFavorite;

  const BookTile(this.title, this.rating, this.notes, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    String rating = "";
    for (var i = 0; i < this.rating; i++) {
      rating += "⭐";
    }

    return Center(
        child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            // height: 100,
            decoration: ShapeDecoration.fromBoxDecoration(
              BoxDecoration(
                color: Colors.red[50],
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(children: <Widget>[
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
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
