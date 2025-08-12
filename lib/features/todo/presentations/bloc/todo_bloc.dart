import 'package:estudos/features/todo/domain/usecases/add_todo.dart';
import 'package:estudos/features/todo/domain/usecases/delete_todo.dart';
import 'package:estudos/features/todo/domain/usecases/get_all_todos.dart';
import 'package:estudos/features/todo/domain/usecases/update_todo.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_event.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodosUseCase getAllTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc({
    required this.getAllTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<EditTodoEvent>(_onEditTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      final todos = await getAllTodosUseCase();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: 'Erro ao carregar os TODOs: ${e.toString()}'));
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodoLoading());
      try {
        await addTodoUseCase(event.todo);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoError(message: 'Erro ao adicionar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onToggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      try {
        final updatedTodo = event.todo.copyWith(
          isCompleted: !event.todo.isCompleted,
        );
        await updateTodoUseCase(updatedTodo);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoError(message: 'Erro ao atualizar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      try {
        await deleteTodoUseCase(event.id);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoError(message: 'Erro ao deletar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      try {
        await updateTodoUseCase(event.todo);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoError(message: 'Erro ao editar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }
}
