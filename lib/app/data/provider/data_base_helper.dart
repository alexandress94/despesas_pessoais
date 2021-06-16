import 'dart:io';
import 'package:despesas_pessoais/app/data/model/transaction_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName      = "transaction.db";
  static final _databaseVersion   = 1;

  static final table              = 'transaction_client';

  static final columnId           = 'id';
  static final columnDescription  = 'description';
  static final columnValue        = 'value';
  static final columnDate         = 'date';
  static final columnRadio        = 'radio';
  static final columnRecipes      = 'recipes';
  static final columnExpenses     = 'expenses';
  

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database>_initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _databaseName;
    var transactionDatabase = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
    return transactionDatabase;
  }

  void _onCreate(Database db, int version) async {
  await db.execute('CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
  '$columnDescription TEXT, $columnValue REAL, $columnDate TEXT, $columnRadio INTEGER,'
  '$columnRecipes REAL, $columnExpenses REAL)');
}

   // Inserir
  Future<int> insert(TransactionModel transaction) async {
    Database db = await instance.database;
    var result = await db.insert(table, transaction.toMap());
    return result;
  }

  // Atualiza
  Future<int> update(TransactionModel transaction) async {
    var db = await instance.database;

    var result = await db.update(table, transaction.toMap(),
        where: '$columnId = ?', whereArgs: [transaction.id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> query() async{
    var db = await instance.database;
    return db.query(table);
  }
  
  Future<TransactionModel> queryOneRow(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(
      table,
      columns: [columnId, columnValue],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length < 0) {
      return TransactionModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var result = await db.query(table, orderBy: "$columnId DESC");
    return result;
  }

  // Deleta
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  // Obtem o número de objetos no banco de dados
  Future<int> count() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> query =
        await db.rawQuery('SELECT COUNT (1) FROM $table');
    int result = Sqflite.firstIntValue(query);
    return result;
  }

  Future<void> clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }

}