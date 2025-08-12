import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<TodoEntity> call(TodoEntity todo) async {
    if (todo.title.trim().isEmpty) {
      throw Exception('O título do TODO não pode ser vazio');
    }
    return await repository.addTodo(todo);
  }
}
