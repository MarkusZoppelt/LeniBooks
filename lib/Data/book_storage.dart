import 'dart:io';
import 'package:LeniBooks/Log/logger.util.dart';
import 'package:LeniBooks/Model/book.dart';
import 'package:LeniBooks/Model/book_collection.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookStorage {
  static final BookStorage instance = BookStorage.internal();
  final log = getLogger();

  List<ValueChanged<List<Book>>> onBooksChanged = List<ValueChanged<List<Book>>>();
  
  List<Book> _allBooks = List<Book>();
  List<Book> get allBooks => _allBooks;

  factory BookStorage({ValueChanged<List<Book>> onBooksChanged}) {
    instance.onBooksChanged.add(onBooksChanged);
    return instance;
  }

  BookStorage.internal(){
    readBooksFromStorage();
    log.d(BookCollection(_allBooks).toJson());
  }

  void addBook(Book book){
    _allBooks.add(book);
    writeBooksToStorage();
    afterBooksChanged();
    log.d(BookCollection(_allBooks).toJson());
  }

  void deleteBook(Book book){
    _allBooks.removeWhere((element) => element.title == book.title);
    writeBooksToStorage();
    afterBooksChanged();
    log.d(BookCollection(_allBooks).toJson());
  }

  void readBooksFromStorage() async{
    try{
      final File storageFile = await _bookStorageFile;
      String contents = await storageFile.readAsString();
      BookCollection decoded = BookCollection.fromJson(contents);
      log.d(decoded.toJson());
      _allBooks = decoded.books;
      
      afterBooksChanged();
    }
    catch(ex) {
      //TODO: actual error handling
      log.e(ex);
      throw ex;
    }
  }

  void writeBooksToStorage() async{
    String encoded = BookCollection(_allBooks).toJson();
    final File storageFile = await _bookStorageFile;
    await storageFile.writeAsString(encoded);
    log.d("Successfully written all books to storage");
  }

  void afterBooksChanged(){
    for(var callback in onBooksChanged){
      callback.call(_allBooks);
    }
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

    BookCollection collection = BookCollection(List<Book>());
    String json = collection.toJson();
    await storageFile.writeAsString(json);

    return true;
  }
}