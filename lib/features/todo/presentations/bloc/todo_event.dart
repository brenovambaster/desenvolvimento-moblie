import 'package:equatable/equatable.dart';
import 'package:estudos/features/todo/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento para carregar a lista de tarefas
class LoadTodosEvent extends TodoEvent {}

// Evento para adicionar uma nova tarefa
class AddTodoEvent extends TodoEvent {
  final TodoEntity todo;

  AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

// Evento para marcar/desmarcar uma tarefa como completa
class ToggleTodoEvent extends TodoEvent {
  final TodoEntity todo;

  ToggleTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

// Evento para deletar uma tarefa
class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// Evento para editar uma tarefa
class EditTodoEvent extends TodoEvent {
  final TodoEntity todo;

  EditTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}
