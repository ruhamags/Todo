import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    
    await db.execute('''
      CREATE TABLE tasks (
        id $idType,
        title $textType,
        isCompleted $boolType,
        priority $textType
      )
    ''');
  }

Future<int> createTask(Task task) async {
  final db = await instance.database; // Ensure the database is initialized
  final id = await db.insert('tasks', task.toMap());
  print("Inserted task with ID: $id"); // Debugging line to check task insertion
  return id;
}

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');

    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
