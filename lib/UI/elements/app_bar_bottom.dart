import 'package:LeniBooks/UI/elements/app_bar_bottom_item.dart';
import 'package:flutter/material.dart';

class AppBarBottom extends StatefulWidget {
  final List<AppBarBottomItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  AppBarBottom({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  @override
  AppBarBottomState createState() => AppBarBottomState();
}

class AppBarBottomState extends State<AppBarBottom>{
  int selectedIndex = 0;

  void updateIndex(int index){
    widget.onTabSelected(index);
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildTabItem({AppBarBottomItem item, int index, ValueChanged<int> onPressed}){
    Color color = selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            splashColor: widget.selectedColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: updateIndex,
      );
    });

    items.insert(items.length >> 1, buildMiddleTabItem());

    return BottomAppBar(
      color: widget.backgroundColor,
      elevation: 2.0,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }
}