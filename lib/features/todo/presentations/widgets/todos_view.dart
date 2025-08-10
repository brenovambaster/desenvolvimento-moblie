import 'package:estudos/features/todo/presentations/bloc/todo_bloc.dart';
import 'package:estudos/features/todo/presentations/bloc/todo_state.dart';
import 'package:estudos/features/todo/presentations/widgets/add_todo_button.dart';
import 'package:estudos/features/todo/presentations/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      // O body do Scaffold
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TodoItem(todo: todo);
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text('Algo deu errado: ${state.message}'));
          }
          return const Center(child: Text('Nenhuma tarefa encontrada'));
        },
      ),
      floatingActionButton: const AddTodoButton(),
    );
  }
}
