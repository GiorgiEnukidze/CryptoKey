import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/login_page.dart';
import 'package:flutter_kryptokey_1/password_list_page.dart';
import 'package:flutter_kryptokey_1/add_password_page.dart';
import 'package:flutter_kryptokey_1/secure_note_page.dart';
import 'package:flutter_kryptokey_1/bank_card_page.dart';
import 'package:flutter_kryptokey_1/id_card_page.dart';
import 'package:flutter_kryptokey_1/encryption_key_page.dart';

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
      home: LoginPage(),
      routes: {
        '/passwordList': (context) => PasswordListPage(),
        '/addPassword': (context) => AddPasswordPage(),
        '/secureNote': (context) => SecureNotePage(),
        '/bankCard': (context) => BankCardPage(),
        '/idCard': (context) => IdCardPage(),
        '/encryptionKey': (context) => EncryptionKeyPage(),
      },
    );
  }
}
