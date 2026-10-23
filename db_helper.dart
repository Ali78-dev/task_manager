import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<int> insertTask(Database db, String title) async {
    return await db.insert('tasks', {'title': title});
  }

  static Future<List<Map<String, dynamic>>> getTasks(Database db) async {
    return await db.query('tasks');
  }

  static Future<int> updateTask(Database db, int id, String title) async {
    return await db.update('tasks', {'title': title}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteTask(Database db, int id) async {
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
