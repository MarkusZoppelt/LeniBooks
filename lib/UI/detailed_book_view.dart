import 'package:LeniBooks/main.dart';
import 'package:flutter/material.dart';
import '../Model/book.dart';

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
        title: Text("Detailed Book View"),
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
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
