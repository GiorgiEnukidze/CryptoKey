import 'package:flutter/material.dart';
import 'add_password_page.dart';
import 'menu_drawer.dart';
import 'encryption_service.dart';

class PasswordListPage extends StatelessWidget {
  final EncryptionService _encryptionService = EncryptionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes mots de passe'),
      ),
      drawer: MenuDrawer(), // Ajoute le menu drawer ici
      body: Center(
        child: Text('Liste des mots de passe'),
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
