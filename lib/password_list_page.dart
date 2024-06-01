import 'package:flutter/material.dart';
import 'add_password_page.dart';

class PasswordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mots de passe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ajouter ici la liste des mots de passe de l'utilisateur
          ],
        ),
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
