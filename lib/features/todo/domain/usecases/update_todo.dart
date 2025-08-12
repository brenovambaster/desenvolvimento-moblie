import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) async {
    // Exemplo de lógica de negócio:
    if (todo.id <= 0) {
      throw Exception('ID ${todo.id} do TODO inválido para atualização');
    }
    if (todo.title.trim().isEmpty) {
      throw Exception('O título do TODO não pode ser vazio');
    }
    await repository.updateTodo(todo);
  }
}
