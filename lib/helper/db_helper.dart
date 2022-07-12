import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper{

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'place.db'),
      onCreate: (db,version) {
        //10_07: Run when first create the database
        return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)');
      },
      version: 1,
    ); //Create a Database or find it if existed
}
  //10_07: Insert into the database
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    //Insert may take some time => Use Future
    final db = await DatabaseHelper.database();
    db.insert(table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace //Replace the existing data with the new one
    );
}

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DatabaseHelper.database();
    return db.query(table);//10_07: Return all the data in the table
  }
}