import 'package:estudos/features/auth/auth_injection.dart';
import 'package:estudos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:estudos/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/implementations/mock.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRemoteDataSource = AuthRemoteDataSourceMock();
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final loginUseCase = LoginUseCase(authRepository);

    return Scaffold(
      body: BlocProvider(
        create: (_) => AuthBloc(AuthInjection.provideLoginUseCase()),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Por favor, preencha todos os campos');
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar('Email inválido');
      return;
    }

    context.read<AuthBloc>().add(
      LoginButtonPressed(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthFailure) {
          _showSnackBar(state.message);
        }
      },
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlutterLogo(size: 120),
              const SizedBox(height: 48),
              Text(
                'Bem-vindo de volta',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Faça login para continuar',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              EmailInput(controller: _emailController),
              const SizedBox(height: 16),
              PasswordInput(controller: _passwordController),
              const SizedBox(height: 32),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state is AuthLoading
                      ? const CircularProgressIndicator()
                      : LoginButton(onPressed: _onLoginPressed);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Componentes visuais puros

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const EmailInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    controller.value = const TextEditingValue(
      text: 'teste@exemplo.com',
    ); //TODO: APAGAR ESSA LINHA
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.email),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    controller.value = const TextEditingValue(
      text: '123456',
    ); //TODO: APAGAR ESSA LINHA
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.lock),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: theme.colorScheme.primary.withOpacity(0.4),
        ),
        child: Text(
          'Entrar',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
