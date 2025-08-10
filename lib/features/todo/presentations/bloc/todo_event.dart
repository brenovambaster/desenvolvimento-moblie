import 'package:equatable/equatable.dart';
import 'package:estudos/features/todo/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoEntity todo;

  AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ToggleTodoEvent extends TodoEvent {
  final TodoEntity todo;

  ToggleTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class EditTodoEvent extends TodoEvent {
  final TodoEntity todo;

  EditTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}
