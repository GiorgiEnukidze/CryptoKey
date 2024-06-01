import 'package:flutter/material.dart';

class AddNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une note sécurisée'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Titre de la note'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Contenu de la note'),
              maxLines: null, // Permet à l'utilisateur de saisir plusieurs lignes
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour enregistrer la note sécurisée
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
