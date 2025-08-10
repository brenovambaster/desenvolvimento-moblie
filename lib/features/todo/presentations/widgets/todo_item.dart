import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_bloc.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;

  const TodoItem({super.key, required this.todo});

  void _showEditDialog(BuildContext context) {
    // Inicializa o controlador com o título atual da tarefa
    final TextEditingController controller = TextEditingController(
      text: todo.title,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Digite o novo título'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String newTitle = controller.text.trim();
                if (newTitle.isNotEmpty) {
                  // Cria uma nova TodoEntity com o título atualizado
                  final updatedTodo = todo.copyWith(title: newTitle);

                  // Dispara o evento de edição para o BLoC
                  context.read<TodoBloc>().add(EditTodoEvent(updatedTodo));

                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
      },
      child: CheckboxListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        value: todo.isCompleted,
        onChanged: (bool? value) {
          context.read<TodoBloc>().add(ToggleTodoEvent(todo));
        },
        // Botão de edição adicionado aqui
        secondary: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _showEditDialog(context),
        ),
      ),
    );
  }
}
