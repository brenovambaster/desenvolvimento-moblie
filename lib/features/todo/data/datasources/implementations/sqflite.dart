import 'package:estudos/core/database/database_helper.dart';
import 'package:estudos/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:estudos/features/todo/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class TodoRemoteDataSourceSqflite implements TodoRemoteDataSource {
  final DatabaseHelper databaseHelper;
  static const _tableName = 'todos';

  TodoRemoteDataSourceSqflite({required this.databaseHelper});

  @override
  Future<List<TodoModel>> getTodos() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    final db = await databaseHelper.database;
    final id = await db.insert(
      _tableName,
      todo.toMapWithoutId(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return todo.copyWith(id: id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final db = await databaseHelper.database;
    await db.update(
      _tableName,
      todo.toMapWithoutId(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await databaseHelper.database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearAllTodos() async {
    final db = await databaseHelper.database;
    await db.execute("delete from $_tableName");
  }
}
