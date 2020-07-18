import 'package:flutter/material.dart';
import '../Model/book.dart';

class AddBookDialogue extends StatefulWidget {
  final void Function(Book book) addBook;

  const AddBookDialogue(this.addBook);

  @override
  _AddBookDialogueState createState() => _AddBookDialogueState();
}

class _AddBookDialogueState extends State<AddBookDialogue> {
  final GlobalKey<FormState> formKey = GlobalKey();
  Book book = Book("", 1, "", false);

  var _title, _rating, notes;

  void saveTitle() {
    if (formKey.currentState.validate()) {}
  }

  void saveRating() {
    if (formKey.currentState.validate()) {}
  }

  void saveNotes() {
    if (formKey.currentState.validate()) {}
  }

  void save() {
    if (formKey.currentState.validate()) {
      widget.addBook(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Please enter Book Title:"),
            TextFormField(
              onChanged: (String txt) => book.title = txt,
              onFieldSubmitted: (String txt) => save(),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Book Rating:"),
            ),
            TextFormField(
              onChanged: (String txt) => book.rating = int.parse(txt),
              onFieldSubmitted: (String txt) => save(),
              validator: (String value) {
                if (value.isEmpty || !(int.parse(value) is int)) {
                  return "Please enter a number 1-5";
                } else if (int.parse(value) < 1 || int.parse(value) > 5) {
                  return "Please enter a number 1-5";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Book Notes:"),
            ),
            TextFormField(
              onChanged: (String txt) => book.note = txt,
              onFieldSubmitted: (String txt) => save(),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
            ),
            RaisedButton(
              color: Colors.pink,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }
}
