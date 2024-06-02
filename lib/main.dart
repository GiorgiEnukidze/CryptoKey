import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/add_bank_card_page.dart';
import 'package:flutter_kryptokey_1/add_encryption_key_page.dart';
import 'package:flutter_kryptokey_1/add_id_card_page.dart';
import 'package:flutter_kryptokey_1/add_note_page.dart';
import 'package:flutter_kryptokey_1/add_password_page.dart';
import 'package:flutter_kryptokey_1/bank_card_page.dart';
import 'package:flutter_kryptokey_1/encryption_key_page.dart';
import 'package:flutter_kryptokey_1/id_card_page.dart';
import 'package:flutter_kryptokey_1/login_page.dart';
import 'package:flutter_kryptokey_1/password_list_page.dart';
import 'package:flutter_kryptokey_1/secure_note_page.dart'; // Importez la page de connexion ici

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoKey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Définissez la route initiale sur la page de connexion
      routes: {
        '/login': (context) => LoginPage(), // Définissez la route vers la page de connexion
        '/passwords': (context) => PasswordListPage(),
        '/add_password': (context) => AddPasswordPage(),
        '/add_bank_card': (context) => AddBankCardPage(),
        '/add_id_card': (context) => AddIdCardPage(),
        '/add_encryption_key': (context) => AddEncryptionKeyPage(),
        '/add_note': (context) => AddNotePage(),
        '/bank_cards': (context) => BankCardPage(),
        '/id_cards': (context) => IdCardPage(),
        '/encryption_keys': (context) => EncryptionKeyPage(),
        '/secure_notes': (context) => SecureNotePage(),
      },
    );
  }
}
