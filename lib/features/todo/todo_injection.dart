import 'package:estudos/features/todo/data/datasources/implementations/mock.dart';
import 'package:estudos/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:estudos/features/todo/data/repositories/todo_repository_impl.dart';

import 'package:estudos/features/todo/domain/repositories/todo_repository.dart';
import 'package:estudos/features/todo/domain/usecases/add_todo.dart';
import 'package:estudos/features/todo/domain/usecases/delete_todo.dart';
import 'package:estudos/features/todo/domain/usecases/get_all_todos.dart';
import 'package:estudos/features/todo/domain/usecases/update_todo.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_bloc.dart';

class TodoInjection {
  static TodoBloc provideTodoBloc() {
    // 1. Instância do DataSource
    // Escolha a implementação do DataSource (Mock ou API)
    final TodoRemoteDataSource remoteDataSource = TodoRemoteDataSourceMock();

    // 2. Instância do Repository
    // Injeta o DataSource no Repository
    final TodoRepository repository = TodoRepositoryImpl(remoteDataSource);

    // 3. Instância dos Usecases
    // Injeta o Repository em cada UseCase
    final getAllTodosUseCase = GetAllTodosUseCase(repository);
    final addTodoUseCase = AddTodoUseCase(repository);
    final updateTodoUseCase = UpdateTodoUseCase(repository);
    final deleteTodoUseCase = DeleteTodoUseCase(repository);

    // 4. Instância do BLoC
    // Injeta todos os Usecases no BLoC
    final todoBloc = TodoBloc(
      getAllTodosUseCase: getAllTodosUseCase,
      addTodoUseCase: addTodoUseCase,
      updateTodoUseCase: updateTodoUseCase,
      deleteTodoUseCase: deleteTodoUseCase,
    );

    return todoBloc;
  }
}
