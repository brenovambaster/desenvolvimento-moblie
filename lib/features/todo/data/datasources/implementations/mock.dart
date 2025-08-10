import 'package:estudos/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:estudos/features/todo/data/models/todo_model.dart';

class TodoRemoteDataSourceMock implements TodoRemoteDataSource {
  // Simula um banco de dados em memória
  final List<TodoModel> _todos = [
    TodoModel(id: 1, title: 'Estudar Flutter', isCompleted: false),
    TodoModel(id: 2, title: 'Fazer compras', isCompleted: true),
    TodoModel(id: 3, title: 'Pagar contas', isCompleted: false),
  ];

  // Simula o próximo ID a ser gerado
  int _nextId = 4;

  // Simula um pequeno delay de rede para todas as operações
  Future<T> _simulateDelay<T>(Future<T> Function() operation) {
    return Future.delayed(const Duration(milliseconds: 500), operation);
  }

  @override
  Future<List<TodoModel>> getTodos() {
    return _simulateDelay(() async => _todos);
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) {
    return _simulateDelay(() async {
      final newTodo = todo.copyWith(id: _nextId++);
      _todos.add(newTodo);
      return newTodo;
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    return _simulateDelay(() async {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
      }
    });
  }

  @override
  Future<void> deleteTodo(int id) {
    return _simulateDelay(() async {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }
}
