import 'package:flutter/material.dart';
import 'add_note_page.dart'; // Ajouter le fichier add_note_page.dart
import 'menu_drawer.dart';

class SecureNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes notes sécurisées'),
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Text('Liste des notes sécurisées'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()), // Remplacer AddNotePage() par le nom de votre page d'ajout de notes
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
