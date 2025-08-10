import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUseCase {
  final TodoRepository repository;

  GetAllTodosUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    // Aqui poderia haver alguma lógica de negócio, como validações,
    // mas neste caso, a operação é simples: apenas chamar o repositório.
    return await repository.getTodos();
  }
}
