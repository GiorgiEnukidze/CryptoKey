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
import 'profile_page.dart';
import 'package:flutter_kryptokey_1/password_export_page.dart';
import 'package:flutter_kryptokey_1/password_import_page.dart';
import 'package:flutter_kryptokey_1/password_share_page.dart';


// Fonction pour vérifier la solidité des mdp
List<dynamic> checkPasswordStrength(String password) {
  int length = password.length;
  bool hasDigit = RegExp(r'\d').hasMatch(password);
  bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  bool hasSpecialChar =
  RegExp(r'''[!@#$%^&*()\-_+=~`\[\]{}|;:"',.<>?/]''').hasMatch(password);  
  List<String> commonPasswords = [
    '123456', 'password', '123456789', 'guest', 'qwerty', '12345678', '111111', '12345',
    'col123456', '123123', '1234567', '1234', '1234567890', '000000', '555555', '666666',
    '123321', '654321', '7777777', '123', 'D1lakiss', '777777', '110110jp', '1111', '987654321',
    '121212', 'Gizli', 'abc123', '112233', 'azerty', '159753', '1q2w3e4r', '54321', 'pass@123',
    '222222', 'qwertyuiop', 'qwerty123', 'qazwsx', 'vip', 'asdasd', '123qwe', '123654', 'iloveyou',
    'a1b2c3', '999999', 'Groupd2013', '1q2w3e', 'usr', 'Liman1000', '1111111', '333333', '123123123',
    '9136668099', '11111111', '1qaz2wsx', 'password1', 'mar20lt', 'gfhjkm', '159357', 'abcd1234',
    '131313', '789456', 'luzit2000', 'aaaaaa', 'zxcvbnm', 'asdfghjkl', '1234qwer', '88888888',
    'dragon', '987654', '888888', 'qwe123', 'football', '3601', 'asdfgh', 'master', 'samsung',
    '12345678910', 'killer', '1237895', '1234561', '12344321', 'daniel', '000000', '444444',
    '101010', 'fuckyou', 'qazwsxedc', '789456123', 'super123', 'qwer1234', '123456789a', '823477aA',
    '147258369', 'unknown', '98765', 'q1w2e3r4', '232323', '102030', '12341234', '147258',
    'shadow', '123456a', '87654321', '10203', 'pokemon', 'princess', 'azertyuiop', 'thomas',
    'baseball', 'monkey', 'jordan', 'michael', 'love', '1111111111', '11223344', '123456789',
    'asdf1234', '147852', '252525', '11111', 'loulou', '111222', 'superman', 'qweasdzxc', 'soccer',
    'qqqqqq', '123abc', 'computer', 'qweasd', 'zxcvbn', 'sunshine', '1234554321', 'asd123',
    'marina', 'lol123', 'a123456', 'Password', '123789', 'jordan23', 'jessica', '212121',
    '7654321', 'googledummy', 'qwerty1', '123654789', 'naruto', 'Indya123', 'internet', 'doudou',
    'anmol123', '55555', 'andrea', 'anthony', 'martin', 'basketball', 'nicole', 'xxxxxx', '1qazxsw2',
    'charlie', '12345qwert', 'zzzzzz', 'q1w2e3', '147852369', 'hello', 'welcome', 'marseille',
    '456123', 'secret', 'matrix', 'zaq12wsx', 'password123', 'qwertyu', 'hunter', 'freedom',
    '999999999', 'eminem', 'junior', '696969', 'andrew', 'michelle', 'wow12345', 'juventus',
    'batman', 'justin', '12qwaszx', 'Pass@123', 'passw0rd', 'soleil', 'nikita', 'Password1',
    'qweqwe', 'nicolas', 'robert', 'starwars', 'liverpool', '5555555', 'bonjour', '124578'
  ];

  bool isNotCommonPassword = !commonPasswords.contains(password);

  int strength = 0;
  List<String> suggestions = [];


  // Length criteria (3 points)
  if (length >= 8) strength += 1;
  if (length >= 12) strength += 1;
  if (length >= 16) strength += 1;
  else suggestions.add('Use at least 16 characters.');

  // Character criteria (4 points)
  if (hasLowercase) strength += 1;
  else suggestions.add('Add lower-case letters.');
  if (hasUppercase) strength += 1;
  else suggestions.add('Add upper-case letters.');
  if (hasDigit) strength += 1;
  else suggestions.add('Add numbers.');
  if (hasSpecialChar) strength += 1;
  else suggestions.add('Add special characters.');


  // Common passwords criteria (3 points)
  if (isNotCommonPassword) strength += 3;
  else suggestions.add('Avoid common passwords.');  

  return [strength, suggestions];
}

// Générer un mot de passe aléatoire

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
  bool _hasSimilarPassword = false; // Utiliser une variable booléenne au lieu d'une liste
  List<String> similarSites = []; // Déclaration de similarSites
  @override
  void initState() {
    super.initState();
    loadPasswords();
    fetchSharedPasswords();
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

  Future<void> fetchSharedPasswords() async {
  try {
    String? token = await storage.read(key: 'auth_token');
    if (token == null) {
      print('Auth token is null');
      return;
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/share/'), // Endpoint pour récupérer les mots de passe partagés
      headers: {'Authorization': 'Bearer $token'},
    );

    print('Share password API response: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      var sharedPasswords = json.decode(response.body) as List<dynamic>;
      // Mise à jour de l'état pour inclure les mots de passe partagés
      setState(() {
        passwords.addAll(sharedPasswords);
      });
      print('Shared passwords: $sharedPasswords');
    } else {
      print('Failed to load shared passwords');
    }
  } catch (e) {
    print('Error: $e');
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

  void _checkSimilarPasswords(BuildContext context, String site, String password, List passwords) {
    similarSites.clear(); // Réinitialiser similarSites

    for (var entry in passwords) {
      var otherSite = entry['site_name'] ?? 'Unknown site';
      var otherPassword = entry['password'] ?? 'Unknown password';

      if (password == otherPassword && site != otherSite) {
        print('Similar password found for different site: $otherSite');
        setState(() {
          _hasSimilarPassword = true; // Utiliser une seule variable booléenne
          similarSites.add(otherSite);
        });
      }
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
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(Icons.person),
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
              title: Text('Secure Note'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecureNotePage()),
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
              title: Text('Déconnexion'),
              onTap: () {
                // Mettez ici le code pour gérer la déconnexion
                // Par exemple, vous pouvez naviguer vers la page de connexion et vider le cache utilisateur
                Navigator.pop(context); // Ferme le menu latéral
                // Insérez ici le code pour effectuer la déconnexion
              },
            ),

          ],
        ),
      ),
      body: passwords.isEmpty ? Center(child: CircularProgressIndicator()): ListView.builder(
              itemCount: passwords.length,
              itemBuilder: (context, index) {
                var passwordEntry = passwords[index];
                var site = passwordEntry['site_name'] ?? 'Unknown site';
                var username = passwordEntry['username'] ?? 'Unknown username';
                var url = passwordEntry['site_url'] ?? 'Unknown url';
                var password = passwordEntry['password'] ?? 'Unknown password';
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      _checkSimilarPasswords(context, site, password, passwords); // Appel de la fonction ici
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
                              int passwordStrength = 0;
                              List<String> suggestions = [];
                              if (password.isNotEmpty) {
                                List<dynamic> result = checkPasswordStrength(password);
                                passwordStrength = result[0];
                                suggestions = result[1];
                              }
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
                                                obscurePassword = !obscurePassword;
                                              });
                                            },
                                            icon: Icon(obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                        ],
                                      ),
                                      Text('Password Strength: $passwordStrength'),
                                      if (suggestions.isNotEmpty)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Suggestions to improve your password:'),
                                            for (var suggestion in suggestions)
                                              Text('- $suggestion'),
                                          ],
                                        ),
                                      Visibility(
                                        visible: _hasSimilarPassword,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              for (var similarSite in similarSites)
                                                Row(
                                                  children: [
                                                    Icon(Icons.warning, color: Colors.red),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'The password for $site is similar to the password for $similarSite.',
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                      var passwordId = passwordEntry['id'] as int?;
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
                                      var newPassword = _generateRandomPassword(12);
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
                                            content: Text(
                                                'Are you sure you want to delete this password?'),
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
                                                    print(
                                                        'Error: Password ID is null or invalid');
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
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordExportPage()),
                    );
                  },
                  child: Icon(Icons.file_upload), // Logo pour importer
                ),
                SizedBox(width: 16), // Espacement entre les boutons
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordSharePage()),
                    );
                  },
                  child: Icon(Icons.share), // Logo pour partager
                ),
                SizedBox(width: 16), // Espacement entre les boutons
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordImportPage ()),
                    );
                  },
                  child: Icon(Icons.file_download), // Logo pour exporter
                ),
                SizedBox(width: 16), // Espacement entre les boutons
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPasswordPage()),
                    );
                  },
                  child: Icon(Icons.add), // Logo pour ajouter
                ),
              ],
      ),  
    );
  }

}



