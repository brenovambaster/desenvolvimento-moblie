import 'package:estudos/features/todo/domain/entities/todo_entity.dart';

class TodoModel {
  final int id;
  final String title;
  final bool isCompleted;

  TodoModel({required this.id, required this.title, required this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  // Método para converter o Data Model em uma Domain Entity
  TodoEntity toEntity() {
    return TodoEntity(id: id, title: title, isCompleted: isCompleted);
  }

  // Método copyWith para criar uma nova instância com dados atualizados
  TodoModel copyWith({int? id, String? title, bool? isCompleted}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
