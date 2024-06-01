import 'package:flutter/material.dart';

class AddEncryptionKeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une clé de cryptage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Type de clé'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Clé'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour enregistrer la clé de cryptage
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
