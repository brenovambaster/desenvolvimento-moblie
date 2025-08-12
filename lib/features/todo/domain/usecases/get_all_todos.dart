import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUseCase {
  final TodoRepository repository;

  GetAllTodosUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getTodos();
  }
}
