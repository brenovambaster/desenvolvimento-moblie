import 'package:estudos/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String email, String password) async {
    // Aqui poderíamos validar email/senha antes de chamar o repositório
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email e senha são obrigatórios");
    }

    return await repository.login(email, password);
  }
}
