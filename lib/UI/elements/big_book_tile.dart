import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/UI/layouts/views/detailed_book_view.dart';
import 'package:flutter/material.dart';

class BigBookTile extends StatefulWidget{
  final String title;
  final int rating;
  final String notes;
  final bool isFavorite;

  const BigBookTile(
    this.title,
    this.rating,
    this.notes,
    this.isFavorite,
  );

  @override
  BigBookTileState createState() => BigBookTileState();
}

class BigBookTileState extends State<BigBookTile>{
  Radius smallRadius = Radius.circular(5.0);
  Radius bigRadius = Radius.circular(20.0);

  Widget buildTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        widget.title,
        style: TextStyle(
          color: Colors.teal[300],
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildRating(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildRatingIcons(context),
      ),
    );
  }

  Widget buildFavIcon(BuildContext context){
    var icon = widget.isFavorite ? Icons.favorite : Icons.favorite_border;
    return Icon(
      icon,
      color: Colors.redAccent,
      size: 30,
    );
  }

  List<Widget> buildRatingIcons(BuildContext context){
    List<Widget> icons = List<Widget>();
    for(int i = 1; i <= 5; i++){
      if(i <= widget.rating){
        icons.add(Icon(Icons.star, color: Colors.teal[200], size: 20,));
      }
      else{
        icons.add(Icon(Icons.star_border, color: Colors.teal[200], size: 20,));
      }
    }

    return icons;
  }

  @override
  Widget build(BuildContext context) {
    var title = buildTitle(context);
    var rating = buildRating(context);
    var favIcon = buildFavIcon(context);

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailedBookView(b: Book(widget.title, widget.rating, widget.notes, widget.isFavorite)))
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Stack(
          children: <Widget>[
            // *** Background ***
            Container(
              height: 220,
              decoration: ShapeDecoration.fromBoxDecoration(
                BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.only(topLeft: smallRadius, bottomLeft: smallRadius, topRight: bigRadius, bottomRight: bigRadius),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 3.0)
                    ),
                  ]
                )
              ),
            ),
            // *** Foreground ***
            Column(
              children: <Widget>[
                title,
                rating,
                favIcon,
              ],
            )
          ],
        )
      )
    );
  }
}