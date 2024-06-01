import 'package:flutter/material.dart';
import 'add_id_card_page.dart'; // Ajouter le fichier add_id_card_page.dart
import 'menu_drawer.dart';

class IdCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes cartes d\'identité'),
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Text('Liste des cartes d\'identité'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIdCardPage()), // Remplacer AddIdCardPage() par le nom de votre page d'ajout de cartes d'identité
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
