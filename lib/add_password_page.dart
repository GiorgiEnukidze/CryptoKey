import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_kryptokey_1/password_service.dart';
import 'package:flutter_kryptokey_1/encryption_service.dart';

class AddPasswordPage extends StatefulWidget {
  @override
  _AddPasswordPageState createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PasswordService _passwordService = PasswordService();
  final EncryptionService _encryptionService = EncryptionService();

  void _generatePassword() {
    final generatedPassword = _passwordService.generatePassword(length: 16);
    setState(() {
      _passwordController.text = generatedPassword;
    });
  }

  void _savePassword() async {
    final url = _urlController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    final encryptedPassword = await _encryptionService.encryptText(password);

    // Add your save logic here. Example:
    // await _encryptionService.storeEncryptedData('password_$url', encryptedPassword);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'URL du site'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePassword,
              child: Text('Générer un mot de passe'),
            ),
            ElevatedButton(
              onPressed: _savePassword,
              child: Text('Sauvegarder'),
            ),
          ],
        ),
      ),
    );
  }
}
