import 'package:flutter/material.dart';
import 'add_bank_card_page.dart'; // Ajouter le fichier add_bank_card_page.dart
import 'menu_drawer.dart';

class BankCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes cartes bancaires'),
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Text('Liste des cartes bancaires'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBankCardPage()), // Remplacer AddBankCardPage() par le nom de votre page d'ajout de cartes bancaires
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
