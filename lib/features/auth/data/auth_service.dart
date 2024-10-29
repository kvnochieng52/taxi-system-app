import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService(this.baseUrl);

  Future<Map<String, dynamic>> register(
      String name, String email, String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
          {'name': name, 'email': email, 'phone': phone, 'password': password}),
    );

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(
      String emailOrPhone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': emailOrPhone, 'password': password}),
    );

    return json.decode(response.body);
  }
}
