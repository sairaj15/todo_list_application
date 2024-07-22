import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._internal();

  static final LocalDatabase _singleton = LocalDatabase._internal();

  factory LocalDatabase(){
    return _singleton;
  }

  late final Database database;

  Future<void> initialize() async{
    final localStoragePath = await getDatabasesPath();
    
    database = await openDatabase(
      '$localStoragePath/database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, isCompleted INTEGER NOT NULL, deletedAt INTEGER, createdAt INTERGER NOT NULL, updatedAt INTEGER, completedAt INTEGER)'
        );
        log("Local Todo Database is created");
      }
    );
  }
}