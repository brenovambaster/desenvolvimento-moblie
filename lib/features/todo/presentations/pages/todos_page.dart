import 'package:estudos/features/todo/presentations/bloc/todo_event.dart';
import 'package:estudos/features/todo/presentations/widgets/todos_view.dart';
import 'package:estudos/features/todo/todo_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // O BlocProvider envolve toda a página para que todos os widgets
    // internos (incluindo o FloatingActionButton) tenham acesso ao BLoC.
    return BlocProvider(
      create: (_) => TodoInjection.provideTodoBloc()..add(LoadTodosEvent()),
      child: const TodosView(),
    );
  }
}
