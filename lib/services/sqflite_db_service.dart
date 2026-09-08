import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/college_model.dart';

class DbService {
  // Singleton pattern instance
  static final DbService instance = DbService._init();
  static Database? _database;

  DbService._init();

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('college_database.db');
    return _database!;
  }

  // Initialize SQLite database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create table schema
  Future<void> _createDB(Database db, int version) async {
    const tableSql = '''
      CREATE TABLE colleges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        location TEXT NOT NULL,
        star INTEGER NOT NULL
      )
    ''';
    await db.execute(tableSql);
  }

  // CREATE: Insert a new college record into database
  Future<int> insertCollege(CollegeModel college) async {
    final db = await instance.database;
    // id is omitted during insert because it is auto-incremented
    final map = college.toMap();
    map.remove('id');
    return await db.insert('colleges', map);
  }

  // READ: Fetch all colleges from database
  Future<List<CollegeModel>> getAllColleges() async {
    final db = await instance.database;
    const orderBy = 'id DESC'; // Latest first
    final result = await db.query('colleges', orderBy: orderBy);

    return result.map((json) => CollegeModel.fromMap(json)).toList();
  }

  // READ: Fetch a single college by its ID
  Future<CollegeModel?> getCollegeById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'colleges',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CollegeModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // SEARCH: Filter colleges by name or location
  Future<List<CollegeModel>> searchColleges(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'colleges',
      where: 'name LIKE ? OR location LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );

    return result.map((json) => CollegeModel.fromMap(json)).toList();
  }

  // UPDATE: Update existing college record
  Future<int> updateCollege(CollegeModel college) async {
    final db = await instance.database;
    return await db.update(
      'colleges',
      college.toMap(),
      where: 'id = ?',
      whereArgs: [college.id],
    );
  }

  // DELETE: Delete a college by ID
  Future<int> deleteCollege(int id) async {
    final db = await instance.database;
    return await db.delete(
      'colleges',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close database connection
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
