import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'mother.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE IF NOT EXISTS mothers ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'firstName TEXT NOT NULL,'
        'lastName TEXT,'
        'pNumber TEXT NOT NULL,'
        'sNumber TEXT,'
        'calMethod TEXT,'
        'calDate TEXT,'
        'dueDate TEXT,'
        'archived INTEGER(1),'
        'notes TEXT)');

    await db
        .execute('CREATE TABLE IF NOT EXISTS doctors ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'fName TEXT NOT NULL,'
        'lName TEXT,'
        'email TEXT NOT NULL,'
        'mobileNo TEXT,'
        'vHospitals TEXT,'
        'password TEXT,'
        'token TEXT NOT NULL,'
        'serverId INTEGER)');

    await db
        .execute(
        'insert into mothers (firstName,lastName,pNumber,sNumber,calMethod) values ("Patient","1","0771212121","0112121212", "LMP")');

    await db
        .execute(
        'insert into mothers (firstName,lastName,pNumber,sNumber,calMethod) values ("Patient","2","0771212121","0112121212", "LMP")');

    await db
        .execute(
        'insert into mothers (firstName,lastName,pNumber,sNumber,calMethod) values ("Patient","3","0771212121","0112121212", "LMP")');

    await db
        .execute(
        'insert into mothers (firstName,lastName,pNumber,sNumber,calMethod) values ("Patient","4","0771212121","0112121212", "LMP")');
  }
}

