
class TodoEntity {
  final int id;
  final String title;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  // Este método permite criar uma nova instância com apenas alguns atributos modificados
  // Segue o princípio da imutabilidade para garantir que os objetos não sejam modificados
  //
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
