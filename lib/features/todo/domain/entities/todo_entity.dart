import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String title;
  final bool isCompleted;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  // Este método permite criar uma nova instância com apenas alguns atributos modificados
  TodoEntity copyWith({int? id, String? title, bool? isCompleted}) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
