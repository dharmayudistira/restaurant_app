import 'package:path/path.dart';
import 'package:restaurant_app/app/data/models/favorite_restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  static final String _tableRestaurant = "restaurants";

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();

    var db = openDatabase(
      join(path, 'restaurant_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableRestaurant (
               id TEXT PRIMARY KEY,
               pictureId TEXT,
               name TEXT,
               rating TEXT,
               city TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> insertRestaurant(FavoriteRestaurant restaurant) async {
    final db = await database;
    await db.insert(_tableRestaurant, restaurant.toMap());
  }

  Future<List<FavoriteRestaurant>> getFavoriteRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableRestaurant);

    return results.map((e) => FavoriteRestaurant.fromMap(e)).toList();
  }

  Future<FavoriteRestaurant?> getFavoriteRestaurantById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) {
      return null;
    } else {
      return results.map((e) => FavoriteRestaurant.fromMap(e)).first;
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
