import 'package:estudos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:estudos/features/auth/domain/usecases/login_usecase.dart';

import 'data/datasources/implementations/mock.dart';

class AuthInjection {
  static LoginUseCase provideLoginUseCase() {
    final remoteDataSource = AuthRemoteDataSourceMock(); // ou Api impl
    final repository = AuthRepositoryImpl(remoteDataSource);
    final useCase = LoginUseCase(repository);
    return useCase;
  }
}
