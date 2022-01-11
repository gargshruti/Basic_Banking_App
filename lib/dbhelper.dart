import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import './Accounts.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';
  static final ttable = 't_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnEmail = 'Email';
  static final columnAmount = 'amount';

  static final fromId = 'fromId';
  static final toId = 'toId';
  static final fromName = 'fromName';
  static final toName = 'toName';

  // make this a singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  // only have a single app-wide reference to the database
  Future<Database> get databse async {
    Database _database = await _initDatabase();
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Future<Database> _initDatabase() async {
  //   String path = await getDatabasesPath();
  //   return await openDatabase(join(path, _databaseName),
  //       version: _databaseVersion, onCreate: _onCreate);
  // }
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnAmount INTEGER NOT NULL
          )
          ''');
    await db.execute('''
              CREATE TABLE $ttable (
            $fromId INTEGER NOT NULL,
            $toId INTEGER NOT NULL,
            $columnAmount INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<List<Map<String, dynamic>>> queryspecific(int idx) async {
    Database db = await instance.databse;
    //res = (await db.query(table, where: 'amount > ?', whereArgs: [amount]))
    //as Future<int>;
    return await db.rawQuery('SELECT * FROM my_table WHERE id != ?', [idx]);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(int id, int amount) async {
    Database db = await instance.databse;

    return await db
        .rawUpdate('UPDATE my_table SET amount = ? WHERE id = ?', [amount, id]);

    // return await db.update(
    //     table, {"id": ?, "Email": "jack234@gmail.com", "amount": 138943},
    //     where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> tinsert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(ttable, row);
  }

  Future<List<Map<String, dynamic>>> tqueryAllRows() async {
    Database db = await instance.databse;
    return await db.query(ttable);
  }

  Future<List<Map<String, dynamic>>> tqueryspecific(int idx) async {
    Database db = await instance.databse;
    //res = (await db.query(table, where: 'amount > ?', whereArgs: [amount]))
    //as Future<int>;
    return await db.rawQuery('SELECT * FROM my_table WHERE id = ?', [idx]);
  }

  void tupdate() async {
    Database db = await instance.databse;

    await db.execute('ALTER TABLE t_table ADD $fromName TEXT');
    await db.execute('ALTER TABLE t_table ADD $toName TEXT');
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  // Future<int> delete(int id) async {
  //   Database db = await instance.databse;
  //   return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  // }
  Future<int> deletetransactions(id) async {
    Database db = await instance.databse;
    return await db.delete(ttable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> UpdateTable(int index) async {
    Database db = await instance.databse;
    return await db.update(
        table,
        {
          "id": index,
          "name": "John",
          "Email": "john982@gmail.com",
          "amount": 250000,
        },
        where: '$columnId = ?',
        whereArgs: [index]);
  }
}
