import 'package:estudos/core/database/database_helper.dart';
import 'package:estudos/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:estudos/features/auth/presentations/bloc/auth_state.dart';
import 'package:estudos/features/auth/presentations/pages/login_page.dart';
import 'package:estudos/features/todo/presentations/pages/todos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/auth_injection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => AuthBloc(AuthInjection.provideLoginUseCase()),
        child: const AppInitializer(),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/todos': (context) => const TodosPage(),
      },
    );
  }
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    // O BlocListener ouve as mudanças de estado do AuthBloc e navega
    // apenas quando o estado é AuthSuccess.
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      // A LoginPage é o ponto de partida.
      child: const LoginPage(),
    );
  }
}

/// Tela principal com um Drawer (menu lateral)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_box_outlined),
              title: const Text('Minhas Tarefas'),
              onTap: () {
                Navigator.of(context).pop(); // Fecha o drawer
                Navigator.pushNamed(context, '/todos');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo! Login realizado com sucesso.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
