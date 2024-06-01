import 'package:flutter/material.dart';
import 'password_list_page.dart';
import 'secure_note_page.dart';
import 'bank_card_page.dart';
import 'id_card_page.dart';
import 'encryption_key_page.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Mots de passe'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordListPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Notes sécurisées'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecureNotePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Cartes bancaires'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankCardPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('Cartes d\'identité'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IdCardPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Clés de cryptage'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EncryptionKeyPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
