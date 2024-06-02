import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('CryptoKey Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('My Passwords'),
            onTap: () {
              Navigator.pushNamed(context, '/passwords');
            },
          ),
          ListTile(
            title: Text('Bank Cards'),
            onTap: () {
              Navigator.pushNamed(context, '/bank_cards');
            },
          ),
          ListTile(
            title: Text('ID Cards'),
            onTap: () {
              Navigator.pushNamed(context, '/id_cards');
            },
          ),
          ListTile(
            title: Text('Encryption Keys'),
            onTap: () {
              Navigator.pushNamed(context, '/encryption_keys');
            },
          ),
          ListTile(
            title: Text('Secure Notes'),
            onTap: () {
              Navigator.pushNamed(context, '/secure_notes');
            },
          ),
        ],
      ),
    );
  }
}
