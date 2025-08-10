// lib/features/auth/auth_injection.dart

import 'package:estudos/features/auth/data/datasources/implementations/mock.dart';
import 'package:estudos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:estudos/features/auth/domain/usecases/login_usecase.dart';

/// Classe responsável por criar e fornecer as dependências da feature Auth.
class AuthInjection {
  /// Cria e retorna uma instância de LoginUseCase com todas as suas dependências configuradas.
  static LoginUseCase provideLoginUseCase() {
    // Aqui você pode trocar facilmente entre implementação mock e real da API
    final remoteDataSource =
        AuthRemoteDataSourceMock(); // Implementação mockada

    // Caso queira usar a implementação real, basta substituir por:
    // final remoteDataSource = AuthRemoteDataSourceImpl(client: http.Client());

    final repository = AuthRepositoryImpl(remoteDataSource);
    final useCase = LoginUseCase(repository);

    return useCase;
  }
}
