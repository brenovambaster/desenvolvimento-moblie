import 'package:equatable/equatable.dart';
import 'package:estudos/features/todo/domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoEntity> todos;

  TodosLoaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});

  @override
  List<Object?> get props => [message];
}
