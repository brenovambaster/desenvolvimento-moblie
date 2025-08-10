import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(int id) async {
    // Exemplo de lógica de negócio:
    if (id <= 0) {
      throw Exception('ID do TODO inválido para exclusão');
    }
    await repository.deleteTodo(id);
  }
}
