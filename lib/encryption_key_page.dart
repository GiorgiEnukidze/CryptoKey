import 'package:flutter/material.dart';
import 'add_encryption_key_page.dart'; // Ajouter le fichier add_encryption_key_page.dart
import 'menu_drawer.dart';

class EncryptionKeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes clés de cryptage'),
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Text('Liste des clés de cryptage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEncryptionKeyPage()), // Remplacer AddEncryptionKeyPage() par le nom de votre page d'ajout de clés de cryptage
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
