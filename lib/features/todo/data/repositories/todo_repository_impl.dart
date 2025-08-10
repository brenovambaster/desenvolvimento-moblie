// features/todo/data/repositories/todo_repository_impl.dart
import 'package:estudos/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:estudos/features/todo/data/models/todo_model.dart';
import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TodoEntity>> getTodos() async {
    try {
      final todoModels = await remoteDataSource.getTodos();
      // Mapeia a lista de Data Models para a lista de Domain Entities
      return todoModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Exemplo de tratamento de erro. Em um projeto real, você usaria uma Failure
      throw Exception("Erro ao buscar a lista de TODOs: ${e.toString()}");
    }
  }

  @override
  Future<TodoEntity> addTodo(TodoEntity todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );
      // Retorna o TodoModel com o ID gerado pelo mock e o converte para Entity
      final newTodoModel = await remoteDataSource.addTodo(todoModel);
      return newTodoModel.toEntity();
    } catch (e) {
      throw Exception("Erro ao adicionar o TODO: ${e.toString()}");
    }
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );
      await remoteDataSource.updateTodo(todoModel);
    } catch (e) {
      throw Exception("Erro ao atualizar o TODO: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await remoteDataSource.deleteTodo(id);
    } catch (e) {
      throw Exception("Erro ao deletar o TODO: ${e.toString()}");
    }
  }
}
