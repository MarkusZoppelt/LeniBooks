import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  void updateUserText(String text) {
    setState(() {
      bookTitle = text;
    });
  }

  String bookTitle = "";
  String rating = "";
  String notes = "";
  @override
  Widget build(BuildContext context) {
    return TextField(
        // onChanged: ,
        // onSubmitted: ,
        );
  }
}
