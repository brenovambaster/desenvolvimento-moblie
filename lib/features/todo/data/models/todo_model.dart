import 'package:estudos/features/todo/domain/entities/todo_entity.dart';

class TodoModel {
  final int id;
  final String title;
  final bool isCompleted;

  TodoModel({required this.id, required this.title, required this.isCompleted});

  // Construtor para criar a partir de um Map (do sqflite)
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  // Método para converter para um Map. Usado para editar um TODO
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  ///
  /// Método para converter para um Map sem o ID (para enviar para a API)bO ID é
  /// gerado automaticamente pelo banco de dados
  ///

  Map<String, dynamic> toMapWithoutId() {
    return {'title': title, 'isCompleted': isCompleted ? 1 : 0};
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
