
import 'package:estudos/features/todo/domain/entities/todo_entity.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_bloc.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final TextEditingController controller = TextEditingController();

        showDialog(
          context: context,
          builder: (dialogContext) {
            // Use um nome diferente para o contexto do diálogo para evitar confusão
            return AlertDialog(
              title: const Text('Adicionar Tarefa'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Digite a tarefa aqui',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    final String title = controller.text.trim();
                    if (title.isNotEmpty) {
                      // Cria uma nova TodoEntity
                      final newTodo = TodoEntity(
                        id: 0,
                        title: title,
                        isCompleted: false,
                      );

                      // Dispara o evento para o BLoC usando o contexto externo
                      // que tem acesso ao BlocProvider.
                      context.read<TodoBloc>().add(AddTodoEvent(newTodo));

                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
