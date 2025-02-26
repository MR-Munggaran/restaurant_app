import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'resto-app.db';
  static const String _tableName = 'resto';
  static const int _version = 2;

  // Membuat tabel database
  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY,    
      name TEXT,
      description TEXT,
      address TEXT,
      city TEXT,
      rating REAL,
      pictureId TEXT
    )
    """,
    );
  }

  // Inisialisasi database
  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<String> insertItem(RestaurantDetail resto) async {
    final db = await _initializeDb();

    final data = resto.toJson();
    print("Inserting data with ID: ${resto.id}");
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Insert returned ID: $id");
    return resto.id;
  }

  Future<List<RestaurantDetail>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    // Debug: Cetak data mentah dari database
    // print("Raw database query results: $results");

    // Debug: Cetak hasil mapping ke RestaurantDetail
    final restaurantList = results.map((result) {
      print("Mapping result: $result");
      return RestaurantDetail.fromJson(result);
    }).toList();

    print("Mapped restaurant list: $restaurantList");
    return restaurantList;
  }

  Future<RestaurantDetail> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => RestaurantDetail.fromJson(result)).first;
  }

  Future<String> removeItem(String id) async {
    final db = await _initializeDb();

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result.toString();
  }
}
