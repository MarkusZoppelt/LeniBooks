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
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            // height: ,
            decoration: ShapeDecoration.fromBoxDecoration(
              BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Column(children: <Widget>[
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
