import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'authentication_service.dart';
import 'password_list_page.dart';
import 'register_page.dart'; // Importez la page d'enregistrement

class LoginPage extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // Initialisation du stockage sécurisé

  void _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final String? token = await _authService.login(username, password);
      if (token != null) {
        await _secureStorage.write(key: 'auth_token', value: token); // Stocker le token de manière sécurisée
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PasswordListPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid username or password'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to login: $e'),
      ));
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()), // Navigation vers la page d'enregistrement
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(height: 20), // Espacement entre les boutons
            TextButton(
              onPressed: () => _navigateToRegister(context),
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
