import 'package:estudos/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();

  Future<TodoModel> addTodo(TodoModel todo);

  Future<void> updateTodo(TodoModel todo);

  Future<void> deleteTodo(int id);
}
