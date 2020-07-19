import 'package:LeniBooks/UI/layouts/pages/my_books_page.dart';
import 'package:LeniBooks/UI/layouts/pages/settings_page.dart';
import 'package:LeniBooks/UI/layouts/pages/to_read_page.dart';
import 'package:flutter/material.dart';
import 'package:LeniBooks/UI/layouts/main_layout.dart';
import 'UI/add_book_dialogue.dart';
import 'UI/layouts/pages/all_books_page.dart';

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
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainLayout(
        allPages: <int, WidgetBuilder> {
          0: (context) => AllBooksPage(),
          1: (context) => MyBooksPage(),
          2: (context) => ToReadPage(),
          3: (context) => SettingsPage(),
        },
      ),
    );
  }
}
