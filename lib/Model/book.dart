import 'dart:convert';

class Book {
  String title;
  int rating;
  String note;
  bool isFavorite;

  Book(
    this.title,
    this.rating,
    this.note,
    this.isFavorite,
  );

  Book.fromJson(String json) {
    var decoded = jsonDecode(json) as Map<String, dynamic>;
    
    title = decoded["title"];
    rating = decoded["rating"];
    note = decoded["note"];
    isFavorite = decoded["isFavorite"];
  }

  String toJson() {
    var temp = {
      "title": title,
      "rating": rating,
      "note": note,
      "isFavorite": isFavorite,
    };
    
    return jsonEncode(temp);
  }
}
