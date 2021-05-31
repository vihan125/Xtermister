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
        .execute('CREATE TABLE mothers ('
        'id integer(10) PRIMARY KEY,'
        'firstName TEXT not null,'
        'lastName TEXT,'
        'pNumber TEXT not null,'
        'sNumber TEXT,'
        'embryoAge integer(4) not null,'
        'calMethod TEXT)');

    await db
        .execute(
        'insert into mothers values ("1","Selena","Gomez","0771212121","0112121212", "266", "LMP")');

    await db
        .execute(
        'insert into mothers values ("2","Taylor","Swift","0771212121","0112121212", "70", "LMP")');

    await db
        .execute(
        'insert into mothers values ("3","Anne","Marrie","0771212121","0112121212", "150", "LMP")');

    await db
        .execute(
        'insert into mothers values ("4","Latha","Walpola","0771212121","0112121212", "200", "LMP")');
  }
}

