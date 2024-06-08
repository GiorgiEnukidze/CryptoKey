import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/add_password_page.dart';
import 'dart:math';
import 'package:flutter_kryptokey_1/bank_card_page.dart';
import 'package:flutter_kryptokey_1/encryption_key_page.dart';
import 'package:flutter_kryptokey_1/id_card_page.dart';
import 'package:flutter_kryptokey_1/secure_note_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Fonction pour vérifier la solidité des mdp
int checkPasswordStrength(String password) {
  int length = password.length;
  bool hasDigit = RegExp(r'\d').hasMatch(password);
  bool hasSpecialChar = RegExp(r'[!@#$%^&*()-_+=~`[\]{}|;:\",.<>?/]').hasMatch(password);
  int strength = 0;

  if (length >= 8) {
    strength += 20;
  }
  if (hasDigit) {
    strength += 20;
  }
  if (hasSpecialChar) {
    strength += 20;
  }

  return strength;
}

String _generateRandomPassword(int length) {
  const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+[]{}|;:,.<>?';
  final Random rnd = Random.secure();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

class PasswordListPage extends StatefulWidget {
  @override
  _PasswordListPageState createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordListPage> {
  List<dynamic> passwords = [];
  final storage = FlutterSecureStorage(); // Initialisez le stockage sécurisé

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  Future<void> loadPasswords() async {
    String? token = await storage.read(key: 'auth_token');
    if (token == null) {
      print('Auth token is null');
      return;
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/passwords/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      setState(() {
        passwords = data;
      });
    } else {
      throw Exception('Failed to load passwords');
    }
  }

  Future<void> _savePassword(int passwordId, String sitename, String siteurl, String username, String password) async {
    if (sitename.isEmpty || siteurl.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    String? token = await storage.read(key: 'auth_token');
    if (token == null) {
      print('Auth token is null');
      return;
    }

    final response = await http.patch(
      Uri.parse('http://127.0.0.1:8000/api/passwords/update/$passwordId/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'site_name': sitename,
        'site_url': siteurl,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Password updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
      // Rafraîchir les mots de passe après une mise à jour réussie
      await loadPasswords();
      // Fermer le dialogue après la mise à jour
      Navigator.of(context).pop();
    } else {
      print('Failed to update password');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update password')));
    }
  }

  Future<void> _deletePassword(int passwordId) async {
    try {
      String? token = await storage.read(key: 'auth_token');
      if (token == null) {
        print('Auth token is null');
        return;
      }

      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/passwords/delete/$passwordId/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password deleted successfully'),
          ),
        );
        // Rafraîchir les mots de passe après une mise à jour réussie
        await loadPasswords();
        // Fermer le dialogue après la mise à jour
        Navigator.of(context).pop();
        await loadPasswords();
      } else {
        print('Failed to delete password: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete password'),
          ),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Passwords'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('CryptoKey Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordListPage()),
                );
              },
            ),
            ListTile(
              title: Text('Bank Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankCardPage()),
                );
              },
            ),
            ListTile(
              title: Text('ID Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IdCardPage()),
                );
              },
            ),
            ListTile(
              title: Text('Encryption Key'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EncryptionKeyPage()),
                );
              },
            ),
            ListTile(
              title: Text('Secure Note'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecureNotePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: passwords.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: passwords.length,
        itemBuilder: (context, index) {
          var passwordEntry = passwords[index];
          var site = passwordEntry['site_name'] ?? 'Unknown site';
          var username = passwordEntry['username'] ??'Unknown username';
          var url = passwordEntry['site_url'] ?? 'Unknown url';
          var password = passwordEntry['password'] ?? 'Unknown password';
          var passwordStrength = checkPasswordStrength(password);
      return ListTile(
        title: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController siteController =
                    TextEditingController(text: site);
                TextEditingController usernameController =
                    TextEditingController(text: username);
                TextEditingController urlController =
                    TextEditingController(text: url);
                TextEditingController passwordController =
                    TextEditingController(text: password);

                bool obscurePassword = true;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text('Password Details'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: siteController,
                              decoration: InputDecoration(
                                labelText: 'Site',
                              ),
                            ),
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                            ),
                            TextField(
                              controller: urlController,
                              decoration: InputDecoration(
                                labelText: 'URL',
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword =
                                          !obscurePassword;
                                    });
                                  },
                                  icon: Icon(obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ],
                            ),
                            Text('Password Strength: $passwordStrength'),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var newSite = siteController.text;
                            var newUsername = usernameController.text;
                            var newUrl = urlController.text;
                            var newPassword = passwordController.text;

                            // Vérifier si passwordEntry contient l'ID du mot de passe et qu'il n'est pas null
                            var passwordId =
                                passwordEntry['id'] as int?;
                            if (passwordId == null) {
                              print('Error: Password ID is null or invalid');
                              return;
                            }

                            // Envoie des nouvelles données au backend et ferme le dialogue
                            await _savePassword(
                                passwordId, newSite, newUrl, newUsername, newPassword);
                          },
                          child: Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var newPassword =
                                _generateRandomPassword(12);
                            setState(() {
                              passwordController.text = newPassword;
                            });
                          },
                          child: Text('Generate Password'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Password?'),
                                  content: Text('Are you sure you want to delete this password?'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        var passwordId = passwordEntry['id'] as int?;
                                        if (passwordId == null) {
                                          print('Error: Password ID is null or invalid');
                                          return;
                                        }
                                        await _deletePassword(passwordId);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Delete Password'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: Text(site),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $username'),
            Text('URL: $url'),
          ],
        ),
      );
    },
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPasswordPage()),
      );
    },
    child: Icon(Icons.add),
  ),
);

          
  }
}