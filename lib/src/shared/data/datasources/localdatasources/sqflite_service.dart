import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static const String _databaseName = 'mangan.db';
  static const String _tableName = 'favorite';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
       id TEXT PRIMARY KEY NOT NULL,
       name TEXT,
       city TEXT,
       pictureId TEXT,
       rating REAL
     )
     """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // membuat item baru
  Future<int> insertItem(RestaurantEntity restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // membaca seluruh item
  Future<List<RestaurantEntity>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName, orderBy: "id");
    return results.map((result) => RestaurantEntity.fromJson(result)).toList();
  }

  // mencari item berdasarkan nilai id
  Future<RestaurantEntity?> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    if (results.isNotEmpty) {
      return RestaurantEntity.fromJson(results.first);
    } else {
      return null;
    }
  }

  // menghapus item berdasarkan nilai id
  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
