import 'package:estudos/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:estudos/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (e) {
      //    Aqui poderia ser tratado usando Failure do core/errors
      throw Exception("Erro ao fazer login");
    }
  }
}
