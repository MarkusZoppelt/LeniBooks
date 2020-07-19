import 'dart:convert';

class Book {
  String _title;
  String get title => _title;
  set title(String title) {
    _title = title;
  }

  int _rating;
  int get rating => _rating;
  set rating(int rating) {
    _rating = rating;
  }

  String _note;
  String get note => _note;
  set note(String note) {
    _note = note;
  }

  bool _isFavorite;
  bool get isFavorite => _isFavorite;
  set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  Book(
    this._title,
    this._rating,
    this._note,
    this._isFavorite,
  );

  Book.fromJson(String json) {
    var decoded = jsonDecode(json) as Map<String, dynamic>;
    
    _title = decoded["title"];
    _rating = decoded["rating"];
    _note = decoded["note"];
    _isFavorite = decoded["isFavorite"];
  }

  String toJson() {
    var temp = {
      "title": _title,
      "rating": _rating,
      "note": _note,
      "isFavorite": _isFavorite,
    };
    
    return jsonEncode(temp);
  }
}
