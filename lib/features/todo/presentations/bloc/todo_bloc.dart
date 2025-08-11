import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
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
      // 1. Otimiza a UI adicionando um item temporário com ID 0
      final optimisticTodo = event.todo.copyWith(id: 0);
      final optimisticTodos = List<TodoEntity>.from(currentState.todos)
        ..add(optimisticTodo);
      emit(TodosLoaded(todos: optimisticTodos));

      try {
        // 2. Chama o usecase, que agora retorna o item com o ID real
        final newTodoWithId = await addTodoUseCase(event.todo);

        // 3. Obtém o estado atual novamente (ele pode ter mudado)
        final postAddState = state;
        if (postAddState is TodosLoaded) {
          // 4. Cria uma nova lista substituindo o item temporário pelo item real
          final updatedTodos =
              postAddState.todos.map((todo) {
                return todo.id == 0 ? newTodoWithId : todo;
              }).toList();
          emit(TodosLoaded(todos: updatedTodos));
        }
      } catch (e) {
        // 5. Se houver um erro, reverte a UI para o estado anterior
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
      // 1. Cria uma nova lista, atualizando o item localmente
      final updatedTodo = event.todo.copyWith(
        isCompleted: !event.todo.isCompleted,
      );
      final updatedTodos =
          currentState.todos.map((todo) {
            return todo.id == updatedTodo.id ? updatedTodo : todo;
          }).toList();
      emit(TodosLoaded(todos: updatedTodos));

      try {
        // 2. Chama o usecase para persistir o dado na fonte externa
        await updateTodoUseCase(updatedTodo);
      } catch (e) {
        // 3. Em caso de falha, reverte a UI para o estado anterior
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
      // 1. Cria uma nova lista, removendo o item localmente
      final updatedTodos =
          currentState.todos.where((todo) => todo.id != event.id).toList();
      emit(TodosLoaded(todos: updatedTodos));

      try {
        // 2. Chama o usecase para persistir o dado na fonte externa
        await deleteTodoUseCase(event.id);
      } catch (e) {
        // 3. Em caso de falha, reverte a UI para o estado anterior
        emit(TodoError(message: 'Erro ao deletar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  // Novo handler para a edição de tarefas
  Future<void> _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      // 1. Cria uma nova lista, substituindo o item antigo pelo novo localmente
      final updatedTodos =
          currentState.todos.map((todo) {
            return todo.id == event.todo.id ? event.todo : todo;
          }).toList();
      emit(TodosLoaded(todos: updatedTodos));

      try {
        // 2. Chama o usecase para persistir a alteração na fonte externa
        await updateTodoUseCase(event.todo);
      } catch (e) {
        // 3. Em caso de falha, reverte a UI para o estado anterior
        emit(TodoError(message: 'Erro ao editar o TODO: ${e.toString()}'));
        emit(currentState);
      }
    }
  }
}
