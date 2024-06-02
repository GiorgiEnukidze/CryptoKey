import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/bank_card_page.dart';
import 'package:flutter_kryptokey_1/encryption_key_page.dart';
import 'package:flutter_kryptokey_1/id_card_page.dart';
import 'package:flutter_kryptokey_1/secure_note_page.dart';
import 'add_password_page.dart';

class PasswordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Passwords'),
      ),
      drawer: Drawer(
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
              title: Text('Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordListPage()),
                );
              },
            ),
            ListTile(
              title: Text('Bank Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankCardPage()),
                );
              },
            ),
            ListTile(
              title: Text('ID Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IdCardPage()),
                );
              },
            ),
            ListTile(
              title: Text('Encryption Key'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EncryptionKeyPage()),
                );
              },
            ),
            ListTile(
              title: Text('Secure Note'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecureNotePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('List of passwords will be displayed here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPasswordPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
