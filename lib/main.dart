import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(CryptoKeyApp());
}

class CryptoKeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoKey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
