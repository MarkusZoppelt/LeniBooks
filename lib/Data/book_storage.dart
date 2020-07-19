import 'dart:convert';
import 'dart:io';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/Model/book_collection.dart';
import 'package:path_provider/path_provider.dart';

class BookStorage {
  static final BookStorage instance = BookStorage.internal();
  
  List<Book> _allBooks;
  List<Book> get allBooks => _allBooks;

  factory BookStorage() {
    return instance;
  }

  BookStorage.internal(){
    _allBooks = [
      Book("Die unendliche Geschichte", 5, "Suppi!", true),
      Book("Can't Hurt Me", 5, "Suppi!", true),
      Book("12 Rules for Life", 1, "Kacke!!", false),
      Book("Tess", 3, "Meh!", false),
      Book("Money", 4, "", false),
    ];
  }

  void addBook(Book book){
    _allBooks.add(book);
  }

  void deleteBook(Book book){
    _allBooks.removeWhere((element) => element.title == book.title);
  }

  void readBooksFromStorage() async{
    //TODO: read from storage file
  }

  void writeBooksToStorage(){
    //TODO: write to storage file
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _bookStorageFile async {
    final String localPath = await _localPath;
    final String path = "$localPath/myBooks.json";

    final File storageFile = File(path);
    final bool storageExists = await storageFile.exists();

    if(!storageExists){
      await initializeStorageFile();
    }

    return storageFile;
  }

  Future<bool> initializeStorageFile() async {
    final String localPath = await _localPath;
    final String path = "$localPath/myBooks.json";

    final File storageFile = File(path);
    await storageFile.create();

    BookCollection collection = BookCollection(_allBooks);
    String json = collection.toJson();
    await storageFile.writeAsString(json);

    return true;
  }
}