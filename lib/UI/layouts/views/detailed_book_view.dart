import 'package:flutter/material.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:share/share.dart';

class DetailedBookView extends StatelessWidget {
  final Book b;
  DetailedBookView({Key key, @required this.b}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rating = "";
    for (var i = 0; i < b.rating; i++) {
      rating += "⭐";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(b.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => {
              Navigator.pop(context, b),
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(b.title),
            Text(rating),
            Text(b.note),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    b.title +
                        "\nRating:" +
                        rating +
                        "\n\nHere are my notes:" +
                        b.note,
                    subject: b.title + ' (shared with LeniBooks)');
              },
            )
          ],
        ),
      ),
    );
  }
}
