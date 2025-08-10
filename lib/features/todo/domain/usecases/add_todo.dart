import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  // O tipo de retorno foi alterado para Future<TodoEntity>
  Future<TodoEntity> call(TodoEntity todo) async {
    if (todo.title.trim().isEmpty) {
      throw Exception('O título do TODO não pode ser vazio');
    }
    // Retorna o TodoEntity que vem do repositório
    return await repository.addTodo(todo);
  }
}
