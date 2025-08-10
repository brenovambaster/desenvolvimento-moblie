abstract class AuthRepository {
  /// Interface for the login use case.
  Future<bool> login(String email, String password);
}
