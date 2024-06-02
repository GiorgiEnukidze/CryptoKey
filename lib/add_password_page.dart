import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class AddPasswordPage extends StatefulWidget {
  @override
  _AddPasswordPageState createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordLengthController = TextEditingController(text: '12');

  String _generateRandomPassword(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+[]{}|;:,.<>?';
    final Random rnd = Random.secure();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _siteController,
              decoration: InputDecoration(labelText: 'Site URL'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _passwordLengthController,
                    decoration: InputDecoration(labelText: 'Password Length'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final int length = int.parse(_passwordLengthController.text);
                    _passwordController.text = _generateRandomPassword(length);
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to save the password
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
