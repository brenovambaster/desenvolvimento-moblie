import 'package:estudos/features/auth/domain/usecases/login_usecase.dart';
import 'package:estudos/features/auth/presentations/bloc/auth_event.dart';
import 'package:estudos/features/auth/presentations/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final success = await loginUseCase(event.email, event.password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Credenciais inválidas'));
      }
    } catch (e) {
      emit(AuthFailure('Erro inesperado: ${e.toString()}'));
    }
  }
}
