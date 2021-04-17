import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_lite_crud/models/contact.dart';

class DatabaseHelper{
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async{
    if(_database != null) return database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath, version: _databaseVersion, onCreate: _onCreateDb);
  }

  _onCreateDb(Database db, int version) async{
    await db.execute('''
    CREATE TABLE ${Contact.tblContact}(
      ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Contact.colName} TEXT NOT NULL,
      ${Contact.colMobile} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertContact(Contact contact) async{
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());
  }
}