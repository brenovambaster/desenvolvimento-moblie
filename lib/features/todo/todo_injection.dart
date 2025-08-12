// features/todo/todo_injection.dart
import 'package:estudos/core/database/database_helper.dart';
import 'package:estudos/features/todo/data/datasources/implementations/sqflite.dart';
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
    // Instância única do gerenciador de banco de dados
    final databaseHelper = DatabaseHelper.instance;

    // O DataSource recebe o DatabaseHelper
    final TodoRemoteDataSource remoteDataSource = TodoRemoteDataSourceSqflite(
      databaseHelper: databaseHelper,
    );

    // O Repositório recebe o DataSource
    final TodoRepository repository = TodoRepositoryImpl(remoteDataSource);

    // Os Usecases recebem o Repositório
    final getAllTodosUseCase = GetAllTodosUseCase(repository);
    final addTodoUseCase = AddTodoUseCase(repository);
    final updateTodoUseCase = UpdateTodoUseCase(repository);
    final deleteTodoUseCase = DeleteTodoUseCase(repository);

    // O BLoC recebe todos os Usecases
    final todoBloc = TodoBloc(
      getAllTodosUseCase: getAllTodosUseCase,
      addTodoUseCase: addTodoUseCase,
      updateTodoUseCase: updateTodoUseCase,
      deleteTodoUseCase: deleteTodoUseCase,
    );

    return todoBloc;
  }
}
