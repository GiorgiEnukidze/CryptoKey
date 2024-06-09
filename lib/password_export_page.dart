import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // Ajouter cette ligne pour importer les classes Directory et File
import 'package:path_provider/path_provider.dart';

class PasswordExportPage extends StatefulWidget {
  @override
  _PasswordExportPageState createState() => _PasswordExportPageState();
}

class _PasswordExportPageState extends State<PasswordExportPage> {
  String _selectedFormat = 'json'; // Format par défaut
  final storage = FlutterSecureStorage();
  List<dynamic> passwords = [];

  Future<void> fetchPasswords() async {
    try {
      String? token = await storage.read(key: 'auth_token');
      if (token == null) {
        print('Auth token is null');
        return;
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/passwords/'), // Endpoint pour récupérer les mots de passe
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Passwords API response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        var passwordsData = json.decode(response.body) as List<dynamic>;
        // Mise à jour de la liste des mots de passe
        setState(() {
          passwords.addAll(passwordsData);
        });
        print('Passwords data: $passwordsData');
      } else {
        print('Failed to load passwords');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _exportPasswords(String format) async {
  try {
    // Lire le token d'authentification depuis le stockage sécurisé
    String? token = await storage.read(key: 'auth_token');
    if (token == null) {
      print('Auth token is null'); // Afficher un message si le token est null
      return;
    }

    // URL de l'API d'exportation des mots de passe
    final apiUrl = 'http://127.0.0.1:8000/api/export/';

    // Envoi de la requête POST à l'API avec le format sélectionné et le token d'authentification
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token', // Ajouter le token d'authentification dans les en-têtes
        'Content-Type': 'application/json', // Spécifier le type de contenu JSON
      },
      body: jsonEncode({'format': format}), // Le corps de la requête contient le format d'exportation
    );

    // Vérifier le code de statut de la réponse
    if (response.statusCode == 200) {
      // Si le code de statut est 200, afficher un message de réussite
      print('Passwords exported successfully');
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Écrire les données exportées dans un fichier temporaire
      File file = File('$tempPath/passwords.$format');
      await file.writeAsString(response.body);
    } else {
      // Sinon, afficher un message d'échec avec le code de statut de la réponse
      print('Failed to export passwords. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Capturer toute exception et afficher un message d'erreur
    print('Error exporting passwords: $e');
  }
}


  @override
  void initState() {
    super.initState();
    fetchPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export Passwords'), // Titre de la page d'exportation de mots de passe
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedFormat,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFormat = newValue!;
                });
              },
              items: <String>['json', 'csv']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _exportPasswords(_selectedFormat);
              },
              child: Text('Export'),
            ),
          ],
        ),
      ),
    );
  }
}
