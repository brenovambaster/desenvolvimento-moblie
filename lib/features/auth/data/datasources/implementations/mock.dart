import 'package:estudos/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  @override
  Future<bool> login(String email, String password) async {
    // Simula um pequeno delay de rede
    await Future.delayed(const Duration(seconds: 1));

    // Dados fictícios para teste
    const mockEmail = "teste@exemplo.com";
    const mockPassword = "123456";

    return email == mockEmail && password == mockPassword;
  }
}
