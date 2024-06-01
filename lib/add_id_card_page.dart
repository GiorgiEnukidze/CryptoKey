import 'package:flutter/material.dart';

class AddIdCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une carte d\'identité'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            // Ajoutez d'autres champs nécessaires pour les informations de la carte d'identité
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour enregistrer la carte d'identité
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
