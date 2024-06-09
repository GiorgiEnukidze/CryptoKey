// authentication_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationService {
  Future<String?> login(String username, String password) async {
    final String apiUrl = 'http://192.168.129.9:8000/api/token/';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      return responseData['access'];
    } else {
      throw Exception('Failed to login');
    }
  }
}
