import 'package:flutter/material.dart';
import 'package:LeniBooks/UI/layouts/dialogues/add_book_dialogue.dart';
import 'package:LeniBooks/UI/elements/app_bar_bottom_item.dart';
import 'package:LeniBooks/UI/elements/app_bar_bottom.dart';

class MainLayout extends StatefulWidget {
  final Map<int, WidgetBuilder> allPages;

  MainLayout({this.allPages});

  @override
  MainLayoutState createState() => MainLayoutState(allPages: allPages);
}

class MainLayoutState extends State<MainLayout> {
  final Map<int, WidgetBuilder> allPages;

  WidgetBuilder currentPage;
  int selectedIndex;

  MainLayoutState({this.allPages}){
    selectedIndex = 0;
    currentPage = allPages[selectedIndex];
  }
  
  void newEntry() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AddBookDialogue(null);
      },
    );
  }

  void setPage(int index){
    setState(() {
      selectedIndex = index;
      currentPage = allPages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // *** Top App Bar ***
      appBar: AppBar(
        title: Text("Leni Books"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.teal[200],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        ),
      ),
      
      // *** Bottom Navbar ***
      bottomNavigationBar: AppBarBottom(
        onTabSelected: setPage,
        items: [
          AppBarBottomItem(iconData: Icons.home, text: "Home"),
          AppBarBottomItem(iconData: Icons.library_books, text: "My Books"),
          AppBarBottomItem(iconData: Icons.library_add, text: "To Read"),
          AppBarBottomItem(iconData: Icons.settings, text: "Settings"),
        ],
        selectedColor: Colors.red[200],
        color: Colors.grey[300],
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: newEntry,
        child: Icon(Icons.add),
        elevation: 2.0,
        backgroundColor: Colors.teal[200],
      ),

      // *** Page View ***
      body: currentPage(context),
    );
  }
}