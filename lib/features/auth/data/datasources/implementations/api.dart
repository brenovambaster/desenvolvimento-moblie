import 'dart:convert';

import 'package:estudos/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceApi implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceApi(this.client);

  @override
  Future<bool> login(String email, String password) async {
    final response = await client.post(
      Uri.parse("https://minhaapi.com/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // Aqui você poderia parsear token, salvar em cache, etc.
      return true;
    } else if (response.statusCode == 401) {
      return false; // Credenciais inválidas
    } else {
      throw Exception("Erro inesperado no servidor");
    }
  }
}
