import 'package:flutter/material.dart';

class AddBankCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une carte bancaire'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Numéro de carte'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nom sur la carte'),
            ),
            // Ajoutez d'autres champs nécessaires pour les informations de la carte bancaire
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour enregistrer la carte bancaire
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
